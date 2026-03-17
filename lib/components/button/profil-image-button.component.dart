import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilImageButton extends ConsumerWidget {
  const ProfilImageButton({super.key, required this.imagePath, this.onClick});

  final String imagePath;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => onClick?.call(),
      child: CircleAvatar(
        radius: 22,
        backgroundImage: CachedNetworkImageProvider(imagePath),
      ),
    );
  }
}
