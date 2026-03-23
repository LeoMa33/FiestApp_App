import 'package:fiestapp/components/button/icon-button.component.dart';
import 'package:fiestapp/components/text/custom-title.component.dart';
import 'package:fiestapp/constant.dart';
import 'package:fiestapp/core/common_widgets/header/header.dart';
import 'package:fiestapp/core/common_widgets/search_bar/search_bar.dart';
import 'package:fiestapp/core/network/client/api_client_provider.dart';
import 'package:fiestapp/core/routing/route_enum.dart';
import 'package:fiestapp/feature/event/data/dto/event_filter_dto.dart';
import 'package:fiestapp/feature/event/data/event_service.dart';
import 'package:fiestapp/feature/event/data/provider/event_details_state.dart';
import 'package:fiestapp/feature/event/data/provider/event_list_state.dart';
import 'package:fiestapp/feature/event/presentation/widgets/home/event_list/dismissible_event_list.dart';
import 'package:fiestapp/feature/event/presentation/widgets/home/event_list/event_list.dart';
import 'package:fiestapp/feature/user/presentation/widgets/external/welcome_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshEvents();
    });
  }

  Future<void> _refreshEvents() async {
    ref.read(eventDetailsProvider.notifier).clear();
    ref.read(eventListProvider.notifier).setLoading(true);
    try {
      final apiClient = ref.read(apiClientProvider);
      final events = await EventService.getAll(
        apiClient: apiClient,
        dto: EventFilterDto(afterDate: DateTime.now()),
      );
      ref.read(eventListProvider.notifier).setEvents(events);
    } catch (e) {
      ref.read(eventListProvider.notifier).setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
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
          context.go(AppRoute.addEvent.path);
        },
      ),
      body: Column(
        children: [
          Header(
            imageUrl: AppImage.homeHeader,
            isBlur: true,
            heightRatio: 3.8,
            top: WelcomeHeader(),
            bottom: CustomSearchBar(
              icon: Icons.search,
              placeholder: "Rechercher",
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 35, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 0,
                  children: [
                    Column(
                      spacing: 10,
                      children: [
                        const CustomTitle(text: "Prochains évènements"),
                        DismissibleEventList(),
                      ],
                    ),
                    Column(
                      spacing: 10,
                      children: [
                        const CustomTitle(text: "Vous y participez"),
                        EventList(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
