import 'package:fiestapp/components/button/icon-button.component.dart';
import 'package:fiestapp/components/details/event-data.component.dart';
import 'package:fiestapp/core/network/s3_service.dart';
import 'package:fiestapp/core/utils/image_converter.dart';
import 'package:fiestapp/feature/event/data/dto/event_dto.dart';
import 'package:fiestapp/feature/event/data/dto/parking_dto.dart';
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
  final PrunesDto? prunes;
  final List<ParkingDto> parkings;

  const EventDetailsWithMap({
    super.key,
    required this.isMapExpanded,
    required this.onExpandToggle,
    required this.event,
    this.prunes,
    this.parkings = const [],
  });

  @override
  ConsumerState<EventDetailsWithMap> createState() =>
      _EventDetailsWithMapState();
}

class _EventDetailsWithMapState extends ConsumerState<EventDetailsWithMap> {
  MapboxMap? _mapboxMap;
  PointAnnotationManager? _pointAnnotationManager;
  bool _mapInitialized = false;

  @override
  void dispose() {
    _mapboxMap = null;
    _pointAnnotationManager = null;
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant EventDetailsWithMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if ((oldWidget.prunes == null && widget.prunes != null) ||
        (oldWidget.parkings.isEmpty && widget.parkings.isNotEmpty)) {
      if (_pointAnnotationManager != null) {
        _addMarkers(_pointAnnotationManager!);
      }
    }
  }

  void _onMapCreated(MapboxMap mapboxMap) async {
    try {
      _mapboxMap = mapboxMap;
      await Future.delayed(const Duration(milliseconds: 100));
      if (!mounted) return;

      await mapboxMap.scaleBar.updateSettings(ScaleBarSettings(enabled: false));
      await _requestLocationPermission();

      _pointAnnotationManager = await mapboxMap.annotations
          .createPointAnnotationManager();
      await _addMarkers(_pointAnnotationManager!);

      setState(() {
        _mapInitialized = true;
      });
    } catch (e) {
      debugPrint('Map initialization error: $e');
    }
  }

  Future<void> _addMarkers(PointAnnotationManager manager) async {
    try {
      await manager.deleteAll();

      // Marker Événement
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

      // Markers Transports
      if (widget.prunes != null) {
        for (final transport in widget.prunes!.transports) {
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
      }

      // Markers Parkings
      for (final parking in widget.parkings) {
        final ByteData bytes = await rootBundle.load(
          'assets/parking_marker.png',
        );
        final Uint8List parkingIcon = bytes.buffer.asUint8List();

        await manager.create(
          PointAnnotationOptions(
            geometry: Point(coordinates: Position(parking.lon, parking.lat)),
            image: parkingIcon,
            iconSize: 0.05,
          ),
        );
      }
    } catch (e) {
      debugPrint('Markers creation error: $e');
    }
  }

  Future<void> _requestLocationPermission() async {
    await Permission.locationWhenInUse.request();
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}
