import 'package:fiestapp/components/modal/create-poll-modal.dart';
import 'package:fiestapp/components/organisation-item/add.component.dart';
import 'package:fiestapp/components/organisation/poll/poll-card.component.dart';
import 'package:fiestapp/feature/estimation/data/dto/estimation_dto.dart';
import 'package:fiestapp/feature/event/data/dto/event_dto.dart';
import 'package:fiestapp/feature/event/data/dto/location_dto.dart';
import 'package:fiestapp/feature/poll/data/dto/poll_dto.dart';
import 'package:fiestapp/feature/user/data/dto/user_light_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    // Mock d'un événement
    final EventDto mockEvent = EventDto(
      name: '',
      id: '',
      description: '',
      date: DateTime.now(),
      address: '',
      location: LocationDto(lat: 0, long: 0),
      creator: UserLightDto(id: '', name: ''),
      participants: [],
      estimation: EstimationDto(beer: 3, pizza: 3, softDrink: 3),
    );

    // Mock d'un sondage
    final List<PollDto> mockPolls = [
      PollDto(
        id: '',
        question: '',
        multiChoice: false,
        timerEnd: DateTime.now(),
        options: [],
        eventId: '',
      ),
    ];

    return Column(
      spacing: 10,
      children: [
        AddCard(
          height: 85,
          width: double.infinity,
          radius: 30,
          onClick: onClick,
        ),
        for (PollDto poll in mockPolls) SondageCard(poll: poll),
      ],
    );
  }
}
