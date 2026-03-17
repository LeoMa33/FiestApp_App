import 'package:fiestapp/components/organisation/who-drive/who-drive-card-bloc.component.dart';
import 'package:fiestapp/components/text/custom-title-expand.component.dart';
import 'package:flutter/material.dart';

class WhoDrive extends StatefulWidget {
  const WhoDrive({super.key});

  @override
  State<WhoDrive> createState() => _WhoDriveState();
}

class _WhoDriveState extends State<WhoDrive> {
  void onClick() {
    print("WhoDrive");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        CustomTitleExpand(
          title: "Qui conduit ?",
          text: "Tout voir",
          onClick: onClick,
        ),
        WhoDriveCardBloc(),
      ],
    );
  }
}
