import 'package:fiestapp/components/modal/create-transport-modal.dart';
import 'package:fiestapp/components/organisation-item/add.component.dart';
import 'package:fiestapp/components/organisation-item/who-card.component.dart';
import 'package:fiestapp/enum.dart';
import 'package:flutter/material.dart';

class WhoDriveCardBloc extends StatefulWidget {
  const WhoDriveCardBloc({super.key});

  @override
  State<WhoDriveCardBloc> createState() => _WhoDriveCardBlocState();
}

class _WhoDriveCardBlocState extends State<WhoDriveCardBloc> {
  Future<void> onClick() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(child: CreateTransportModal());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        AddCard(
          height: 85,
          width: double.infinity,
          radius: 30,
          onClick: onClick,
        ),
        WhoDriveCard(type: WhoCardType.drive),
      ],
    );
  }
}
