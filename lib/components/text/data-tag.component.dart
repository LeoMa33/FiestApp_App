import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DataTag extends ConsumerWidget {
  const DataTag({
    super.key,
    required this.text,
    this.icon,
    this.iconColor,
    this.backgroundColor,
    this.s3ImageUrl,
    this.imageSize = 20,
  }) : assert(
         (icon != null && s3ImageUrl == null) ||
             (icon == null && s3ImageUrl != null),
         'Vous devez fournir soit une icône soit une URL S3, mais pas les deux',
       );

  final String text;
  final IconData? icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final String? s3ImageUrl;
  final double imageSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(spacing: 5, children: [_buildIcon(), Text(text)]),
    );
  }

  Widget _buildIcon() {
    if (icon != null) {
      return FaIcon(icon!, color: iconColor ?? Colors.black, size: imageSize);
    } else if (s3ImageUrl != null) {
      return Image.network(
        s3ImageUrl!,
        width: imageSize,
        height: imageSize,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          // Widget de fallback en cas d'erreur de chargement
          return FaIcon(
            FontAwesomeIcons.image,
            color: Colors.grey,
            size: imageSize,
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return SizedBox(
            width: imageSize,
            height: imageSize,
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                    : null,
              ),
            ),
          );
        },
      );
    } else {
      return FaIcon(
        FontAwesomeIcons.image,
        color: Colors.grey,
        size: imageSize,
      );
    }
  }
}
