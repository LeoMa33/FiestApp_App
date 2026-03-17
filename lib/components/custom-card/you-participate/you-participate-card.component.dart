import 'package:fiestapp/components/custom-card/card-header.component.dart';
import 'package:fiestapp/components/custom-card/you-participate/you-participate-bottom-card.component.dart';
import 'package:fiestapp/core/routing/route_enum.dart';
import 'package:fiestapp/core/routing/router.dart';
import 'package:fiestapp/provider/event/selected-event.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openapi/openapi.dart';

class YouParticipateCard extends ConsumerWidget {
  const YouParticipateCard({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.read(routerProvider).pushNamed(AppRoute.details.name);
        ref.read(selectedEventProvider.notifier).fetchSelectedEvent(event.guid);
      },
      child: Container(
        height: 250,
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
              date: "12/07/2025",
              height: 140,
              width: 340,
            ),
            YouParticipateBottomCardComponent(
              eventCreatorName: event.organizer.username,
              eventCreatorImage: event.organizer.guid,
              users: event.participants.toList(),
              eventName: event.title,
              eventLocation: event.location,
            ),
          ],
        ),
      ),
    );
  }
}
