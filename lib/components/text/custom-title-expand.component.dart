import 'package:fiestapp/components/text/custom-title.component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomTitleExpand extends ConsumerWidget {
  const CustomTitleExpand({
    super.key,
    required this.title,
    required this.text,
    required this.onClick,
  });

  final String title;
  final String text;
  final Function() onClick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTitle(text: title),
        GestureDetector(
          onTap: onClick,
          child: Text(
            text,
            style: TextStyle(
              color: Color(0xffE15B42),
              fontSize: 14,
              decoration: TextDecoration.underline,
              decorationColor: Color(0xffE15B42),
            ),
          ),
        ),
      ],
    );
  }
}