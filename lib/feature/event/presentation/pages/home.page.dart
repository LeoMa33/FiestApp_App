import 'package:fiestapp/components/button/icon-button.component.dart';
import 'package:fiestapp/components/home/header/home-header.component.dart';
import 'package:fiestapp/components/home/next-event/next-event.component.dart';
import 'package:fiestapp/components/home/participation/you-participate.component.dart';
import 'package:fiestapp/core/routing/route_enum.dart';
import 'package:fiestapp/core/routing/router.dart';
import 'package:fiestapp/provider/event/event.provider.dart';
import 'package:fiestapp/provider/user.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:openapi/openapi.dart';
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
    _future = ref.read(eventProvider.notifier).fetchAllEvents();
    ref.read(userProvider.notifier).getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
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
          HomeHeader(userName: user?.username ?? "Utilisateur"),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 35),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: FutureBuilder(
                    future: _future,
                    builder: (context, snapshot) {
                      final isLoading =
                          snapshot.connectionState == ConnectionState.waiting;
                      return Skeletonizer(
                        enabled: isLoading,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          spacing: 35,
                          children: [NextEvent(), YouParticipate()],
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
