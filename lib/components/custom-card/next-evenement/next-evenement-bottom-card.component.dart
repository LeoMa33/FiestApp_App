import 'package:fiestapp/components/custom-card/creator-event-name/creator-event-name.component.dart';
import 'package:flutter/material.dart';

class NextEvenementBottomCard extends StatelessWidget {
  const NextEvenementBottomCard({
    super.key,
    required this.eventName,
    required this.eventLocation,
    required this.eventCreatorName,
    required this.eventCreatorImage,
  });

  final String eventName;
  final String eventLocation;
  final String eventCreatorName;
  final String eventCreatorImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 25.0, right: 25.0),
      child: Column(
        spacing: 7.5,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            eventName,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CreatorEventName(
                eventCreatorName: eventCreatorName,
                eventCreatorImage: eventCreatorImage,
              ),
              Text(
                '📍 $eventLocation',
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
