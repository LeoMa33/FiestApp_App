import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;

Future<Uint8List> createCustomMarker(String networkImageUrl) async {
  try {
    // 1. Charger l'image réseau avec timeout
    final http.Response response = await http
        .get(Uri.parse(networkImageUrl))
        .timeout(const Duration(seconds: 10));

    if (response.statusCode != 200) {
      throw Exception(
        "Erreur de téléchargement image réseau: ${response.statusCode}",
      );
    }
    final Uint8List networkImageBytes = response.bodyBytes;

    // 2. Charger le fond du marker depuis les assets
    final ByteData markerByteData = await rootBundle.load('assets/marker.png');
    final Uint8List markerBytes = markerByteData.buffer.asUint8List();

    // 3. Décoder les deux images avec vérification
    final img.Image? markerBaseDecoded = img.decodeImage(markerBytes);
    final img.Image? overlayDecoded = img.decodeImage(networkImageBytes);

    if (markerBaseDecoded == null) {
      throw Exception("Impossible de décoder l'image marker depuis les assets");
    }

    if (overlayDecoded == null) {
      throw Exception("Impossible de décoder l'image réseau");
    }

    img.Image markerBase = markerBaseDecoded;
    img.Image overlay = overlayDecoded;

    // 4. Calculer la taille du cercle
    final int diameter = (markerBase.width * 0.7).toInt();
    final double radius = diameter / 2.0;

    // 5. Préparer l'image overlay : crop carré puis resize
    final int smallestSide = min(overlay.width, overlay.height);
    overlay = img.copyCrop(
      overlay,
      x: (overlay.width - smallestSide) ~/ 2,
      y: (overlay.height - smallestSide) ~/ 2,
      width: smallestSide,
      height: smallestSide,
    );

    overlay = img.copyResize(overlay, width: diameter, height: diameter);

    // 6. Créer l'image finale en copiant le marker base
    final img.Image finalImage = img.Image.from(markerBase);

    // 7. Calculer la position pour centrer l'overlay sur le marker
    final int offsetX = (markerBase.width - diameter) ~/ 2.3;
    final int offsetY = (markerBase.height - diameter) ~/ 4.5;

    // 8. Appliquer le masque circulaire avec anti-aliasing
    final double centerX = diameter / 2.0;
    final double centerY = diameter / 2.0;

    for (int y = 0; y < diameter; y++) {
      for (int x = 0; x < diameter; x++) {
        // Calculer la distance du centre avec précision
        final double distance = sqrt(
          (x - centerX) * (x - centerX) + (y - centerY) * (y - centerY),
        );

        // Appliquer un anti-aliasing basique
        double alpha = 1.0;
        if (distance > radius - 1.0) {
          if (distance > radius) {
            continue; // Pixel complètement en dehors du cercle
          } else {
            // Pixel sur le bord : calculer l'alpha pour l'anti-aliasing
            alpha = radius - distance;
          }
        }

        // Récupérer le pixel de l'overlay
        final overlayPixel = overlay.getPixel(x, y);

        // Position finale dans l'image marker
        final int finalX = offsetX + x;
        final int finalY = offsetY + y;

        // Vérifier les limites
        if (finalX >= 0 &&
            finalX < finalImage.width &&
            finalY >= 0 &&
            finalY < finalImage.height) {
          if (alpha >= 1.0) {
            // Pixel complètement opaque
            finalImage.setPixel(
              finalX,
              finalY,
              img.ColorRgba8(
                overlayPixel.r.toInt(),
                overlayPixel.g.toInt(),
                overlayPixel.b.toInt(),
                255,
              ),
            );
          } else {
            // Pixel semi-transparent pour l'anti-aliasing
            final existingPixel = finalImage.getPixel(finalX, finalY);
            final int blendedR =
                (overlayPixel.r * alpha + existingPixel.r * (1 - alpha))
                    .toInt();
            final int blendedG =
                (overlayPixel.g * alpha + existingPixel.g * (1 - alpha))
                    .toInt();
            final int blendedB =
                (overlayPixel.b * alpha + existingPixel.b * (1 - alpha))
                    .toInt();

            finalImage.setPixel(
              finalX,
              finalY,
              img.ColorRgba8(blendedR, blendedG, blendedB, 255),
            );
          }
        }
      }
    }

    // 9. Encoder l'image finale en PNG
    final Uint8List finalMarker = Uint8List.fromList(img.encodePng(finalImage));
    return finalMarker;
  } catch (e) {
    print("Erreur lors de la création du marker personnalisé: $e");
    return await _getDefaultMarker();
  }
}

Future<Uint8List> _getDefaultMarker() async {
  final ByteData markerByteData = await rootBundle.load('assets/marker.png');
  return markerByteData.buffer.asUint8List();
}
