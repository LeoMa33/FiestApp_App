import 'package:fiestapp/components/custom-card/you-participate/you-participate-card.component.dart';
import 'package:fiestapp/components/text/custom-title.component.dart';
import 'package:fiestapp/provider/event/event.provider.dart';
import 'package:fiestapp/provider/user.provider.dart';
import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilEvenements extends ConsumerWidget {
  const ProfilEvenements({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Event> events = ref.watch(eventProvider);
    final User? currentUser = ref.read(userProvider);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        spacing: 10,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [CustomTitle(text: 'Vos évènements')],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                spacing: 10,
                children: events
                    .where(
                      (event) =>
                          event.organizer.guid == currentUser?.guid,
                    )
                    .map((event) => YouParticipateCard(event: event))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
