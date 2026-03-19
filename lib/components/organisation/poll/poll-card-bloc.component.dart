import 'package:fiestapp/components/modal/create-poll-modal.dart';
import 'package:fiestapp/components/organisation-item/add.component.dart';
import 'package:fiestapp/components/organisation/poll/poll-card.component.dart';
import 'package:fiestapp/feature/event/domain/models/event.dart';
import 'package:fiestapp/feature/poll/domain/models/poll-option.dart';
import 'package:fiestapp/feature/poll/domain/models/poll.dart';
import 'package:fiestapp/feature/user/domain/models/user.dart';
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
    // Mock d'un utilisateur
    final mockUser = User(
      userGuid: 'user-1',
      username: 'Léo',
      gender: 'male',
      age: 25,
      height: 180,
      weight: 75,
      alcoholConsumption: 'casual',
      ppLink: null,
    );

    // Mock d'un événement
    final mockEvent = Event(
      guid: 'event-1',
      title: 'Soirée Mock',
      description: 'Description',
      location: 'Paris',
      latitute: 48.8566,
      longitude: 2.3522,
      date: DateTime.now().millisecondsSinceEpoch,
      organizer: mockUser,
      participants: [],
      expenses: [],
    );

    // Mock d'un sondage
    final List<Poll> mockPolls = [
      Poll(
        guid: 'poll-1',
        event: mockEvent,
        question: 'On mange quoi ?',
        pollOptions: [
          PollOption(guid: 'opt-1', pollGuid: 'poll-1', option: 'Pizza'),
          PollOption(guid: 'opt-2', pollGuid: 'poll-1', option: 'Burger'),
        ],
        createdAt: DateTime.now().millisecondsSinceEpoch,
      ),
    ];

    return Column(
      spacing: 10,
      children: [
        AddCard(height: 85, width: double.infinity, radius: 30, onClick: onClick),
        for (Poll poll in mockPolls) SondageCard(poll: poll),
      ],
    );
  }
}
