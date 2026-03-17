import 'package:fiestapp/components/avatar-group/avatar-group.component.dart';
import 'package:fiestapp/components/custom-card/creator-event-name/creator-event-name.component.dart';
import 'package:openapi/openapi.dart';
import 'package:flutter/material.dart';

class YouParticipateBottomCardComponent extends StatelessWidget {
  final String eventCreatorName;
  final String eventCreatorImage;
  final List<User> users;
  final String eventName;
  final String eventLocation;

  const YouParticipateBottomCardComponent({
    super.key,
    required this.eventCreatorName,
    required this.eventCreatorImage,
    required this.users,
    required this.eventName,
    required this.eventLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 25.0, right: 25.0),
      child: Column(
        spacing: 5,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CreatorEventName(
                eventCreatorName: eventCreatorName,
                eventCreatorImage: eventCreatorImage,
              ),
              AvatarGroup(
                users: users,
                haveBackground: false,
                textColor: Colors.black,
                text: users.length.toString(),
              ),
            ],
          ),
          Text(
            eventName,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          Text(
            '📍 $eventLocation',
            style: TextStyle(fontSize: 12, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
