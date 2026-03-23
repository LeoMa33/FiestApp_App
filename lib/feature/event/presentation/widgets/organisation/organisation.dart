import 'package:fiestapp/feature/accomodation/presentation/widgets/accomodation_list_bloc.dart';
import 'package:fiestapp/feature/event/data/provider/event_details_state.dart';
import 'package:fiestapp/feature/expense/presentation/widgets/external/expenses_list_bloc.dart';
import 'package:fiestapp/feature/poll/presentation/widgets/external/poll_list_bloc.dart';
import 'package:fiestapp/feature/shopping/presentation/widgets/external/shopping_list.dart';
import 'package:fiestapp/feature/transport/presentation/widgets/transport_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Organisation extends ConsumerWidget {
  const Organisation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(eventDetailsProvider);

    if (state.event == null) {
      return const Center(child: Text("Événement non trouvé"));
    }

    if (state.prunes == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final prunes = state.prunes!;
    final event = state.event!;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PollListBloc(polls: prunes.polls),
            ShoppingList(
              shoppingItems: prunes.shoppingItems,
              estimation: event.estimation,
            ),
            TransportListBloc(transports: prunes.transports),
            AccomodationListBloc(accomodations: prunes.accomodations),
            ExpenseListBloc(expenses: prunes.expenses),
          ],
        ),
      ),
    );
  }
}
