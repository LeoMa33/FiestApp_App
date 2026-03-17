import 'package:cached_network_image/cached_network_image.dart';
import 'package:fiestapp/components/custom-card/tablet-date/tablet-date.component.dart';
import 'package:flutter/material.dart';

class CardHeader extends StatelessWidget {
  const CardHeader({
    super.key,
    required this.pathImage,
    required this.date,
    required this.height,
    required this.width,
  });

  final String pathImage;
  final String date;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(40)),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: const Color(0xffFFFFFF),
            image: DecorationImage(
              image: CachedNetworkImageProvider(pathImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [TabletDate(date: date)],
            ),
          ),
        ),
      ),
    );
  }
}
