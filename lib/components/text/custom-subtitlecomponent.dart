import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomSubTitle extends ConsumerWidget {
  const CustomSubTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      title,
      style: TextStyle(
        color: Color(0xffE15B42),
        fontSize: 12,
        decorationColor: Color(0xffE15B42),
      ),
    );
  }
}
