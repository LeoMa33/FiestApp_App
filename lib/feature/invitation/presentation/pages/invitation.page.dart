import 'package:fiestapp/components/details/details-header.component.dart';
import 'package:fiestapp/components/details/event-data-with-map.component.dart';
import 'package:fiestapp/provider/event/selected-event.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openapi/openapi.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Invitation extends ConsumerStatefulWidget {
  final String id;

  const Invitation({super.key, required this.id});

  @override
  InvitationState createState() => InvitationState();
}

class InvitationState extends ConsumerState<Invitation> {
  bool isMapExpanded = false;
  late Future<Event?> _future;

  @override
  void initState() {
    super.initState();
    _future = ref
        .read(selectedEventProvider.notifier)
        .fetchSelectedEvent(widget.id);
  }

  void ExpandMap() {
    setState(() {
      isMapExpanded = !isMapExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: const Color(0xffF4F1F7),
        body: FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
            final isLoading =
                snapshot.connectionState == ConnectionState.waiting;
            return Skeletonizer(
              enabled: isLoading,
              child: Column(
                spacing: 10,
                children: [
                  if (!isMapExpanded)
                    DetailsHeader(
                      height: MediaQuery.sizeOf(context).height / 3,
                    ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: EventDetailsWithMap(
                        isMapExpanded: isMapExpanded,
                        onExpandToggle: ExpandMap,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
