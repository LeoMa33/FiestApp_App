import 'package:fiestapp/core/network/s3_service.dart';
import 'package:fiestapp/core/routing/route_enum.dart';
import 'package:fiestapp/feature/event/data/dto/event_dto.dart';
import 'package:fiestapp/feature/event/presentation/widgets/event_card/card/card.dart';
import 'package:fiestapp/feature/event/presentation/widgets/event_card/footer/card_footer.dart';
import 'package:fiestapp/feature/event/presentation/widgets/event_card/header/card_header.dart';
import 'package:fiestapp/feature/user/presentation/widgets/external/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NextEventCard extends StatelessWidget {
  final EventDto event;

  const NextEventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      height: 201,
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
            height: 122,
            width: 340,
          ),
          CardFooter(
            child: Column(
              spacing: 7.5,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  event.name,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    UserAvartLabel(user: event.creator),
                    Text(
                      '📍 ${event.address}',
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
