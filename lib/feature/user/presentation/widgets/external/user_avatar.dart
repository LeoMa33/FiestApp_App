import 'package:cached_network_image/cached_network_image.dart';
import 'package:fiestapp/core/network/s3_service.dart';
import 'package:fiestapp/feature/user/data/dto/user_light_dto.dart';
import 'package:flutter/material.dart';

class UserAvartLabel extends StatelessWidget {
  const UserAvartLabel({super.key, required this.user});

  final UserLightDto user;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 2.5,
      children: [
        CircleAvatar(
          radius: 11.5,
          backgroundImage: CachedNetworkImageProvider(
            S3Service.getUserImage(user.imageUrl),
          ),
        ),
        Text(
          user.name,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
