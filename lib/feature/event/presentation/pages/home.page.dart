import 'package:fiestapp/components/button/icon-button.component.dart';
import 'package:fiestapp/components/home/header/home-header.component.dart';
import 'package:fiestapp/components/home/next-event/next-event.component.dart';
import 'package:fiestapp/components/home/participation/you-participate.component.dart';
import 'package:fiestapp/core/routing/route_enum.dart';
import 'package:fiestapp/core/routing/router.dart';
import 'package:fiestapp/feature/event/domain/models/event.dart';
import 'package:fiestapp/feature/user/domain/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  late Future<List<Event>> _future;

  @override
  void initState() {
    super.initState();
    // Simulation d'un chargement avec un mock
    _future = Future.delayed(
      const Duration(seconds: 2),
      () => [
        Event(
          guid: '1',
          title: 'Soirée Mock',
          description: 'Une super soirée de test',
          location: 'Paris, France',
          latitute: 48.8566,
          longitude: 2.3522,
          date: DateTime.now().millisecondsSinceEpoch,
          organizer: User(
            userGuid: 'user-1',
            username: 'Léo',
            gender: 'M',
            age: 25,
            height: 180,
            weight: 75,
            alcoholConsumption: 'Occasinnelle',
            ppLink: null,
          ),
          participants: [],
          expenses: [],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = {'username': 'test'};
    return Scaffold(
      backgroundColor: Color(0xffF4F1F7),
      resizeToAvoidBottomInset: false,
      floatingActionButton: CustomIconButton(
        icon: FontAwesomeIcons.calendarPlus,
        backgroundColor: Color(0xffE15B42),
        iconColor: Colors.white,
        height: 80,
        width: 80,
        size: 20,
        onClick: () {
          ref.read(routerProvider).push(AppRoute.addEvent.path);
        },
      ),
      body: Column(
        children: [
          HomeHeader(userName: user['username'] ?? "Utilisateur"),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 35),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: FutureBuilder<List<Event>>(
                    future: _future,
                    builder: (context, snapshot) {
                      final isLoading = snapshot.connectionState == ConnectionState.waiting;
                      final events = snapshot.data ?? [];

                      return Skeletonizer(
                        enabled: isLoading,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          spacing: 35,
                          children: [
                            NextEvent(events: events),
                            YouParticipate(),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
