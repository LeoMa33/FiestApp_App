import 'package:fiestapp/components/organisation/where-sleep/where-sleep-card-bloc.component.dart';
import 'package:fiestapp/components/text/custom-title-expand.component.dart';
import 'package:flutter/material.dart';

class WhereSleep extends StatefulWidget {
  const WhereSleep({super.key});

  @override
  State<WhereSleep> createState() => _WhereSleepState();
}

class _WhereSleepState extends State<WhereSleep> {
  void onClick() {
    print("WhereSleep");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        CustomTitleExpand(
          title: "Je dors où ?",
          text: "Tout voir",
          onClick: onClick,
        ),
        WhereSleepBloc(),
      ],
    );
  }
}
