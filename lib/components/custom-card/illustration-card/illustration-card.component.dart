import 'package:fiestapp/components/button/profil-image-button.component.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IllustrationCard extends StatelessWidget {
  const IllustrationCard({
    super.key,
    this.icon,
    this.iconColor,
    this.backgroundColor,
    this.s3ImageUrl,
    this.imageSize = 20,
    this.onClick,
    this.isSelected = false,
    this.gradient,
    this.isUser = false,
    required this.principalLabel,
    required this.secondaryLabel,
  });

  final String principalLabel;
  final String secondaryLabel;
  final IconData? icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final String? s3ImageUrl;
  final double imageSize;
  final VoidCallback? onClick;
  final bool isSelected;
  final Gradient? gradient;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: isSelected ? gradient : null,
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIcon(),
            Text(
              principalLabel,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
            Text(
              secondaryLabel,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Colors.white70 : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    if (isUser && s3ImageUrl != null) {
      return ProfilImageButton(imagePath: s3ImageUrl!);
    }
    if (icon != null) {
      return FaIcon(
        icon!,
        color: isSelected == true
            ? Colors
                  .white // couleur quand sélectionné
            : (iconColor ?? Colors.black), // sinon, valeur par défaut
        size: imageSize,
      );
    } else if (s3ImageUrl != null) {
      return Image.network(
        s3ImageUrl!,
        width: imageSize,
        height: imageSize,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          // Widget de fallback en cas d'erreur de chargement
          print(error);

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
