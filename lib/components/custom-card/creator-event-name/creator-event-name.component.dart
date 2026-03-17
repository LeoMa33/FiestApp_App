import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CreatorEventName extends StatelessWidget {
  const CreatorEventName({
    super.key,
    required this.eventCreatorName,
    required this.eventCreatorImage,
  });

  final String eventCreatorName;
  final String eventCreatorImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 2.5,
      children: [
        CircleAvatar(
          radius: 11.5,
          backgroundImage: CachedNetworkImageProvider(eventCreatorImage),
        ),
        Text(
          eventCreatorName,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
