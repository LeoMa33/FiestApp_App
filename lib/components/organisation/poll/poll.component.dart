import 'package:fiestapp/components/organisation/poll/poll-card-bloc.component.dart';
import 'package:fiestapp/components/text/custom-title-expand.component.dart';
import 'package:flutter/material.dart';

class Sondage extends StatefulWidget {
  const Sondage({super.key});

  @override
  State<Sondage> createState() => _SondageState();
}

class _SondageState extends State<Sondage> {
  void onClick() {
    print("Sondage");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        CustomTitleExpand(
          title: "Sondages",
          text: "Tout voir",
          onClick: onClick,
        ),
        SondageCardBloc(),
      ],
    );
  }
}
