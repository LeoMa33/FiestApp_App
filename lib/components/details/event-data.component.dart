import 'package:fiestapp/components/button/column-icon-button.component.dart';
import 'package:fiestapp/components/details/event-description.component.dart';
import 'package:fiestapp/components/details/event-title.component.dart';
import 'package:fiestapp/components/details/planning-data-block.component.dart';
import 'package:fiestapp/core/utils/date_utils.dart';
import 'package:fiestapp/feature/event/domain/models/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EventData extends ConsumerWidget {
  const EventData({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isInvitation = false; // Check si la pagge set une invite
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        spacing: 10,
        children: [
          PlanningDataBlock(
            date: formatDate(event.date.toInt()),
            hour: formatHour(event.date.toInt()),
          ),
          EventTitle(title: event.title, adress: event.location),

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
                      onPressed: () => {},
                    ),
                  ),
                  Expanded(
                    child: ColumnIconButton(
                      icon: FontAwesomeIcons.circleCheck,
                      label: 'Accepter',
                      onPressed: () => {},
                    ),
                  ),
                  Expanded(
                    child: ColumnIconButton(
                      icon: FontAwesomeIcons.minus,
                      color: Colors.white,
                      textColor: Colors.black,
                      label: 'Indisponible',
                      onPressed: () => {},
                    ),
                  ),
                ],
              ),
            ),

          EventDescription(description: "Hey viens à mon évènement !"),
        ],
      ),
    );
  }
}
