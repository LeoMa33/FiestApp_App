import 'package:fiestapp/components/modal/create-poll-modal.dart';
import 'package:fiestapp/components/organisation-item/add.component.dart';
import 'package:fiestapp/components/organisation/poll/poll-card.component.dart';
import 'package:fiestapp/provider/event/selected-event.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openapi/openapi.dart';


class SondageCardBloc extends ConsumerStatefulWidget {
  const SondageCardBloc({super.key});

  @override
  ConsumerState<SondageCardBloc> createState() => _SondageCardBlocState();
}

class _SondageCardBlocState extends ConsumerState<SondageCardBloc> {
  Future<void> onClick() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(child: CreatePollModal());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Event? event = ref.watch(selectedEventProvider);

    return Column(
      spacing: 10,
      children: [
        AddCard(
          height: 85,
          width: double.infinity,
          radius: 30,
          onClick: onClick,
        ),
        for (Poll poll in event!.polls)
          SondageCard(poll: poll,),
      ],
    );
  }
}
