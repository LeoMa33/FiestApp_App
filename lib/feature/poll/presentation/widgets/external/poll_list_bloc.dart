import 'package:fiestapp/components/modal/create-poll-modal.dart';
import 'package:fiestapp/components/organisation-item/add.component.dart';
import 'package:fiestapp/components/text/custom-title-expand.component.dart';
import 'package:fiestapp/feature/poll/data/dto/poll_dto.dart';
import 'package:fiestapp/feature/poll/presentation/widgets/poll_card.dart';
import 'package:flutter/material.dart';

class PollListBloc extends StatelessWidget {
  const PollListBloc({super.key, required this.polls});

  final List<PollDto> polls;

  void onClick() {
    print("Sondage");
  }

  Future<void> createPoll(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const Dialog(child: CreatePollModal());
      },
    );
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
        Column(
          spacing: 10,
          children: [
            AddCard(
              height: 85,
              width: double.infinity,
              radius: 30,
              onClick: () => createPoll(context),
            ),
            ...polls.map((poll) => PollCard(poll: poll)),
          ],
        ),
      ],
    );
  }
}
