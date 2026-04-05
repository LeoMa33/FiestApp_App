import 'package:fiestapp/components/button/column-icon-button.component.dart';
import 'package:fiestapp/components/details/event-description.component.dart';
import 'package:fiestapp/components/details/event-title.component.dart';
import 'package:fiestapp/components/details/planning-data-block.component.dart';
import 'package:fiestapp/core/utils/date_utils.dart';
import 'package:fiestapp/feature/event/data/dto/event_dto.dart';
import 'package:fiestapp/feature/invitation/data/provider/invitation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EventData extends ConsumerWidget {
  const EventData({super.key, required this.event});

  final EventDto event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invitationId = ref.watch(invitationIdProvider);
    final isInvitation = invitationId != null;

    final actions = InvitationActions(ref, context);

    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        spacing: 10,
        children: [
          PlanningDataBlock(
            date: formatDate(event.date),
            hour: formatHour(event.date),
          ),
          EventTitle(title: event.name, adress: event.address),
          if (isInvitation)
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: ColumnIconButton(
                      icon: FontAwesomeIcons.circleXmark,
                      label: 'Refuser',
                      color: Colors.black,
                      onPressed: () => actions.refuse(),
                    ),
                  ),
                  Expanded(
                    child: ColumnIconButton(
                      icon: FontAwesomeIcons.circleCheck,
                      label: 'Accepter',
                      onPressed: () => actions.accept(),
                    ),
                  ),
                  Expanded(
                    child: ColumnIconButton(
                      icon: FontAwesomeIcons.minus,
                      color: Colors.white,
                      textColor: Colors.black,
                      label: 'Indisponible',
                      onPressed: () => actions.unavailable(),
                    ),
                  ),
                ],
              ),
            ),
          EventDescription(description: event.description),
        ],
      ),
    );
  }
}
