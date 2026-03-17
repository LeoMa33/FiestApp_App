import 'package:fiestapp/components/text/custom-subtitlecomponent.dart';
import 'package:fiestapp/components/text/data-tag.component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TotalBloc extends ConsumerWidget {
  const TotalBloc({super.key, required this.total});

  final double total;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        CustomSubTitle(title: "Total des dépenses"),
        Row(
          spacing: 5,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DataTag(
              icon: FontAwesomeIcons.moneyBillWave,
              iconColor: Color(0xffABC760),
              text: "$total €",
            ),
          ],
        ),
      ],
    );
  }
}
