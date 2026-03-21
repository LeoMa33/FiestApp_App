import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.imageUrl,
    this.top,
    this.bottom,
    this.isBlur = false,
    this.heightRatio = 0.5,
  });

  final Widget? top;
  final Widget? bottom;
  final String imageUrl;
  final bool isBlur;
  final double heightRatio;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(40),
        bottomRight: Radius.circular(40),
      ),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        width: double.infinity,
        height: MediaQuery.sizeOf(context).height / heightRatio,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: isBlur ? 20 : 0,
            sigmaY: isBlur ? 20 : 0,
          ),
          child: Container(
            color: Color(0xFFE15B42).withValues(alpha: 0.3),
            child: SafeArea(
              minimum: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 45,
                bottom: 10,
              ),
              bottom: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: top,
                  ),
                  Padding(padding: const EdgeInsets.all(7.0), child: bottom),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
