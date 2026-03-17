import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelector extends StatefulWidget {
  final String title;
  final double width;
  final double height;
  final Function(XFile?) onImageSelect;

  const ImageSelector({
    super.key,
    required this.title,
    required this.onImageSelect,
    this.width = 350,
    this.height = 180,
  });

  @override
  State<ImageSelector> createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  String? _selectedImage;

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      setState(() {
        _selectedImage = image.path;
        print('Image selected: $_selectedImage');
        widget.onImageSelect(image);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => pickImage(ImageSource.gallery),
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: const Color(0xFFE15B42), width: 3),
        ),
        clipBehavior: Clip.antiAlias,
        // pour arrondir l'image
        child: _selectedImage == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const FaIcon(
                    FontAwesomeIcons.image,
                    size: 40,
                    color: Color(0xFFE15B42),
                  ),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            : Image.file(
                File(_selectedImage!),
                fit: BoxFit.cover,
                width: widget.width,
                height: widget.height,
              ),
      ),
    );
  }
}
