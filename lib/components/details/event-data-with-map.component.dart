import 'package:fiestapp/components/button/icon-button.component.dart';
import 'package:fiestapp/components/details/event-data.component.dart';
import 'package:fiestapp/core/network/s3_service.dart';
import 'package:fiestapp/core/utils/image_converter.dart';
import 'package:fiestapp/feature/event/data/dto/event_dto.dart';
import 'package:fiestapp/feature/event/data/dto/prunes_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class EventDetailsWithMap extends ConsumerStatefulWidget {
  final bool isMapExpanded;
  final VoidCallback onExpandToggle;
  final EventDto event;
  final PrunesDto prunes;

  const EventDetailsWithMap({
    super.key,
    required this.isMapExpanded,
    required this.onExpandToggle,
    required this.event,
    required this.prunes,
  });

  @override
  ConsumerState<EventDetailsWithMap> createState() =>
      _EventDetailsWithMapState();
}

class _EventDetailsWithMapState extends ConsumerState<EventDetailsWithMap> {
  MapboxMap? _mapboxMap;
  bool _mapInitialized = false;

  @override
  void dispose() {
    _mapboxMap = null;
    super.dispose();
  }

  void _onMapCreated(MapboxMap mapboxMap) async {
    try {
      _mapboxMap = mapboxMap;

      await Future.delayed(const Duration(milliseconds: 100));
      if (!mounted) return;

      await mapboxMap.scaleBar.updateSettings(ScaleBarSettings(enabled: false));

      await _requestLocationPermission();

      try {
        await mapboxMap.location.updateSettings(
          LocationComponentSettings(
            enabled: true,
            puckBearingEnabled: true,
            pulsingEnabled: true,
            showAccuracyRing: true,
          ),
        );
      } catch (e) {
        debugPrint('Location settings error: $e');
      }

      final pointAnnotationManager = await mapboxMap.annotations
          .createPointAnnotationManager();

      await _addMarkers(pointAnnotationManager);

      setState(() {
        _mapInitialized = true;
      });
    } catch (e) {
      debugPrint('Map initialization error: $e');
    }
  }

  Future<void> _addMarkers(PointAnnotationManager manager) async {
    try {
      // Marker pour l'événement
      Uint8List eventMarkerImage = await createCustomMarker(
        S3Service.getEventImage(widget.event.imageUrl),
      );

      await manager.create(
        PointAnnotationOptions(
          geometry: Point(
            coordinates: Position(
              widget.event.location.long,
              widget.event.location.lat,
            ),
          ),
          image: eventMarkerImage,
          iconSize: 1,
        ),
      );

      for (final transport in widget.prunes.transports) {
        Uint8List carMarkerImage = await createCarMarker(
          S3Service.getUserImage(transport.driver.imageUrl),
        );
        await manager.create(
          PointAnnotationOptions(
            geometry: Point(
              coordinates: Position(
                transport.location.long,
                transport.location.lat,
              ),
            ),
            image: carMarkerImage,
            iconSize: 0.23,
          ),
        );
      }
    } catch (e) {
      debugPrint('Markers creation error: $e');
    }
  }

  Future<void> _requestLocationPermission() async {
    try {
      var status = await Permission.locationWhenInUse.request();
      if (status.isDenied && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Permission de localisation nécessaire pour afficher votre position',
            ),
          ),
        );
      }
    } catch (e) {
      debugPrint('Permission request error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final CameraOptions camera = CameraOptions(
      center: Point(
        coordinates: Position(
          widget.event.location.long,
          widget.event.location.lat,
        ),
      ),
      zoom: 15,
      bearing: 0,
      pitch: 0,
    );

    return Column(
      spacing: 10,
      children: [
        if (!widget.isMapExpanded) EventData(event: widget.event),
        SafeArea(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
            width: double.infinity,
            height: widget.isMapExpanded
                ? MediaQuery.of(context).size.height * 0.92
                : 200,
            child: Stack(
              children: [
                MapWidget(
                  key: const ValueKey('stable-mapbox-map'),
                  textureView: false,
                  cameraOptions: camera,
                  onMapCreated: _onMapCreated,
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: CustomIconButton(
                    icon: !widget.isMapExpanded
                        ? FontAwesomeIcons.upRightAndDownLeftFromCenter
                        : FontAwesomeIcons.downLeftAndUpRightToCenter,
                    backgroundColor: Colors.black.withOpacity(0.2),
                    iconColor: Colors.white,
                    onClick: widget.onExpandToggle,
                  ),
                ),
                if (!_mapInitialized)
                  Container(
                    color: Colors.grey.shade200,
                    child: const Center(child: CircularProgressIndicator()),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
