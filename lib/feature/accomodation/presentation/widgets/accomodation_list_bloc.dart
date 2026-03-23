import 'package:fiestapp/components/modal/create-sleep-modal.dart';
import 'package:fiestapp/components/organisation-item/add.component.dart';
import 'package:fiestapp/components/text/custom-title-expand.component.dart';
import 'package:fiestapp/feature/accomodation/data/dto/accomodation_dto.dart';
import 'package:fiestapp/feature/accomodation/presentation/widgets/accomodation_card.dart';
import 'package:flutter/material.dart';

class AccomodationListBloc extends StatelessWidget {
  const AccomodationListBloc({super.key, required this.accomodations});

  final List<AccommodationDto> accomodations;

  void onClick() {
    print("WhereSleep");
  }

  Future<void> createAccomodation(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const Dialog(child: CreateSleepModal());
      },
    );
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
        Column(
          spacing: 10,
          children: [
            AddCard(
              height: 85,
              width: double.infinity,
              radius: 30,
              onClick: () => createAccomodation(context),
            ),
            ...accomodations.map(
              (accomodation) => AccomodationCard(accomodation: accomodation),
            ),
          ],
        ),
      ],
    );
  }
}
