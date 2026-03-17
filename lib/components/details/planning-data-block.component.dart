import 'package:fiestapp/components/text/data-tag.component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PlanningDataBlock extends ConsumerWidget {
  const PlanningDataBlock({super.key, required this.date, required this.hour});

  final String date;
  final String hour;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      spacing: 5,
      children: [
        DataTag(
          text: date,
          icon: FontAwesomeIcons.calendar,
          iconColor: Color(0xffE15B42),
        ),
        DataTag(
          text: "$hour h",
          icon: FontAwesomeIcons.clock,
          iconColor: Color(0xffE15B42),
        ),
      ],
    );
  }
}
