import 'package:fiestapp/core/network/client/api_client_provider.dart';
import 'package:fiestapp/core/routing/route_enum.dart';
import 'package:fiestapp/feature/event/data/provider/event_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final invitationIdProvider = StateProvider<String?>((ref) => null);

class InvitationActions {
  final WidgetRef ref;
  final BuildContext context;

  InvitationActions(this.ref, this.context);

  Future<void> accept() async {
    final id = ref.read(invitationIdProvider);
    if (id == null) return;

    try {
      final apiClient = ref.read(apiClientProvider);
      final updatedEvent = await apiClient.invitation.accept(id);

      ref.read(eventDetailsProvider.notifier).setEvent(updatedEvent);

      ref.read(invitationIdProvider.notifier).state = null;

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Vous avez rejoint l'événement !")),
        );
      }
    } catch (e) {
      if (context.mounted) {
        _handleError();
      }
    }
  }

  void refuse() {
    context.goNamed(AppRoute.home.name);
  }

  void unavailable() {
    context.goNamed(AppRoute.home.name);
  }

  void _handleError() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Invitation invalide ou expirée"),
        backgroundColor: Colors.red,
      ),
    );
    context.goNamed(AppRoute.home.name);
  }
}
