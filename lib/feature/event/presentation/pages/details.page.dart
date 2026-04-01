import 'package:fiestapp/components/details/details-header.component.dart';
import 'package:fiestapp/components/details/event-data-with-map.component.dart';
import 'package:fiestapp/core/common_widgets/page_switcher/page-switcher.component.dart';
import 'package:fiestapp/core/network/client/api_client_provider.dart';
import 'package:fiestapp/feature/event/data/event_service.dart';
import 'package:fiestapp/feature/event/data/provider/event_details_state.dart';
import 'package:fiestapp/feature/event/presentation/widgets/organisation/organisation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Details extends ConsumerStatefulWidget {
  const Details({super.key, required this.id});

  final String id;

  @override
  DetailState createState() => DetailState();
}

class DetailState extends ConsumerState<Details> {
  bool isMapExpanded = false;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialData();
      _loadOrganisationData();
    });
  }

  Future<void> _loadInitialData() async {
    final notifier = ref.read(eventDetailsProvider.notifier);
    final apiClient = ref.read(apiClientProvider);

    notifier.setLoading(true);
    try {
      final event = await EventService.getById(
        apiClient: apiClient,
        id: widget.id,
      );
      notifier.setEvent(event);
    } catch (e) {
      notifier.setLoading(false);
    }
  }

  Future<void> _loadOrganisationData() async {
    final state = ref.read(eventDetailsProvider);
    if (state.prunes != null) return;

    final notifier = ref.read(eventDetailsProvider.notifier);
    final apiClient = ref.read(apiClientProvider);

    try {
      final prunes = await EventService.getPrunes(
        apiClient: apiClient,
        id: widget.id,
      );
      notifier.setPrunes(prunes);
    } catch (e) {
      print(e);
    }
  }

  void expandMap() {
    setState(() {
      isMapExpanded = !isMapExpanded;
    });
  }

  void changePage(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(eventDetailsProvider);

    if (state.isLoading && state.event == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (state.event == null) {
      return const Scaffold(body: Center(child: Text("Évènement non trouvé")));
    }

    return SafeArea(
      top: false,
      child: Scaffold(
        bottomNavigationBar: isMapExpanded
            ? SizedBox()
            : Padding(
                padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
                child: PageSwitcher(
                  onPageChanged: changePage,
                  currentPage: currentPage,
                  firstPage: 'Informations',
                  secondPage: 'Organisation',
                ),
              ),

        backgroundColor: const Color(0xffF4F1F7),
        body: Column(
          spacing: 10,
          children: [
            if (!isMapExpanded)
              DetailsHeader(
                height:
                    MediaQuery.sizeOf(context).height /
                    (currentPage == 0 ? 3 : 3.8),
              ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: currentPage == 1
                      ? const Organisation()
                      : EventDetailsWithMap(
                          isMapExpanded: isMapExpanded,
                          onExpandToggle: expandMap,
                          event: state.event!,
                          prunes: state.prunes,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
