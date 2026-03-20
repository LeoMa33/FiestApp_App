import 'package:fiestapp/components/custom-card/card-header.component.dart';
import 'package:fiestapp/components/custom-card/next-evenement/next-evenement-bottom-card.component.dart';
import 'package:fiestapp/core/utils/date_utils.dart';
import 'package:fiestapp/feature/event/domain/models/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NextEvenementCard extends ConsumerWidget {
  final Event event;

  const NextEvenementCard({super.key, required this.event});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 201,
        width: 350,
        decoration: BoxDecoration(
          color: Color(0xffFFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(40)),
          boxShadow: [
            BoxShadow(
              color: Color(0x0AE15B42), // 4% d'opacité ≈ 0A en hexadécimal
              offset: Offset(0, 4), // X = 0, Y = 4
              blurRadius: 4,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          children: [
            CardHeader(
              pathImage:
                  'https://tripxl.com/blog/wp-content/uploads/2024/09/Subsix-Underwater-Nightclub-Niyama-Private-Islands.jpg',
              date: formatDate(event.date),
              height: 122,
              width: 340,
            ),
            NextEvenementBottomCard(
              eventName: event.title,
              eventLocation: event.location,
              eventCreatorName: event.organizer.username,
              eventCreatorImage: event.organizer.userGuid,
            ),
          ],
        ),
      ),
    );
  }
}
