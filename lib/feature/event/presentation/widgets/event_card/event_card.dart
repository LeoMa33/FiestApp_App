import 'package:fiestapp/core/network/s3_service.dart';
import 'package:fiestapp/core/routing/route_enum.dart';
import 'package:fiestapp/feature/event/data/dto/event_dto.dart';
import 'package:fiestapp/feature/event/presentation/widgets/event_card/card/card.dart';
import 'package:fiestapp/feature/event/presentation/widgets/event_card/footer/card_footer.dart';
import 'package:fiestapp/feature/event/presentation/widgets/event_card/header/card_header.dart';
import 'package:fiestapp/feature/user/data/dto/user_light_dto.dart';
import 'package:fiestapp/feature/user/presentation/widgets/external/avatar_group.dart';
import 'package:fiestapp/feature/user/presentation/widgets/external/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EventCard extends ConsumerWidget {
  const EventCard({super.key, required this.event});

  final EventDto event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<UserLightDto> users = [];

    return CustomCard(
      height: 250,
      width: 350,
      click: () => {
        context.goNamed(
          AppRoute.details.name,
          queryParameters: {'id': event.id},
        ),
      },
      child: Column(
        children: [
          CardHeader(
            pathImage: S3Service.getEventImage(event.imageUrl),
            date: event.date,
            height: 140,
            width: 340,
          ),
          CardFooter(
            child: Column(
              spacing: 5,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    UserAvartLabel(user: event.creator),
                    AvatarGroup(
                      users: users,
                      haveBackground: false,
                      textColor: Colors.black,
                      text: event.participants.length.toString(),
                    ),
                  ],
                ),
                Text(
                  event.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '📍 ${event.address}',
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
