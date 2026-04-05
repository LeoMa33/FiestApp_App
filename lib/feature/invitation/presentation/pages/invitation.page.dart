import 'package:fiestapp/components/details/details-header.component.dart';
import 'package:fiestapp/components/details/event-data-with-map.component.dart';
import 'package:fiestapp/core/network/client/api_client_provider.dart';
import 'package:fiestapp/feature/event/data/dto/event_dto.dart';
import 'package:fiestapp/feature/event/data/event_service.dart';
import 'package:fiestapp/feature/event/data/provider/event_details_state.dart';
import 'package:fiestapp/feature/invitation/data/provider/invitation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Invitation extends ConsumerStatefulWidget {
  final String id;

  const Invitation({super.key, required this.id});

  @override
  InvitationState createState() => InvitationState();
}

class InvitationState extends ConsumerState<Invitation> {
  bool isMapExpanded = false;
  EventDto? event;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(invitationIdProvider.notifier).state = widget.id;
    });
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadData() async {
    final apiClient = ref.read(apiClientProvider);
    final notifier = ref.read(eventDetailsProvider.notifier);

    try {
      final invitation = await apiClient.invitation.getById(widget.id);

      final eventData = await EventService.getById(
        apiClient: apiClient,
        id: invitation.eventId,
      );

      notifier.setEvent(eventData);

      if (mounted) {
        setState(() {
          event = eventData;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invitation invalide ou expirée")),
        );
      }
    }
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
        body: Skeletonizer(
          enabled: isLoading,
          child: event == null && !isLoading
              ? const Center(child: Text("Événement introuvable"))
              : Column(
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
                        child: event != null
                            ? EventDetailsWithMap(
                                isMapExpanded: isMapExpanded,
                                onExpandToggle: ExpandMap,
                                event: event!,
                              )
                            : const SizedBox(),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
