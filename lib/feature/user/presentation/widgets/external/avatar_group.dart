import 'package:cached_network_image/cached_network_image.dart';
import 'package:fiestapp/core/network/s3_service.dart';
import 'package:fiestapp/feature/user/data/dto/user_light_dto.dart';
import 'package:flutter/material.dart';

class AvatarGroup extends StatelessWidget {
  const AvatarGroup({
    super.key,
    required this.users,
    required this.haveBackground,
    this.textColor,
    this.text,
  });

  final List<UserLightDto> users;
  final bool haveBackground;
  final Color? textColor;
  final String? text;

  @override
  Widget build(BuildContext context) {
    const maxAvatars = 3;
    final displayUsers = users.take(maxAvatars).toList();

    final content = Row(
      spacing: 5,
      children: [
        SizedBox(
          height: 30,
          width: 20 * displayUsers.length + 10,
          child: Stack(
            children: List.generate(displayUsers.length, (index) {
              final user = displayUsers[index];
              return Positioned(
                left: index * 18,
                child: CircleAvatar(
                  radius: 15,
                  backgroundImage: CachedNetworkImageProvider(
                    S3Service.getUserImage(user.imageUrl),
                  ),
                ),
              );
            }),
          ),
        ),
        if (text != null) Text(text!, style: TextStyle(color: textColor)),
      ],
    );

    return Container(
      decoration: BoxDecoration(
        color: haveBackground ? Colors.black.withAlpha(50) : Colors.transparent,
        borderRadius: BorderRadius.circular(25),
      ),
      child: haveBackground
          ? Padding(padding: const EdgeInsets.all(10), child: content)
          : content,
    );
  }
}
