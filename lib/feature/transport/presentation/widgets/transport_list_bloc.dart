import 'package:fiestapp/components/modal/create-transport-modal.dart';
import 'package:fiestapp/components/organisation-item/add.component.dart';
import 'package:fiestapp/components/text/custom-title-expand.component.dart';
import 'package:fiestapp/feature/transport/data/dto/transport_dto.dart';
import 'package:fiestapp/feature/transport/presentation/widgets/transport_card.dart';
import 'package:fiestapp/feature/user/data/provider/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransportListBloc extends ConsumerWidget {
  const TransportListBloc({super.key, required this.transports});

  final List<TransportDto> transports;

  Future<void> _onClick(BuildContext context, WidgetRef ref) {
    final user = ref.read(userSessionProvider).user;

    if (user != null && user.age < 18) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Vous devez être majeur pour créer un transport"),
          backgroundColor: Colors.red,
        ),
      );
      return Future.value();
    }

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const Dialog(child: CreateTransportModal());
      },
    );
  }

  void onClick() {
    print("WhoDrive");
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      spacing: 10,
      children: [
        CustomTitleExpand(
          title: "Qui conduit ?",
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
              onClick: () => _onClick(context, ref),
            ),
            ...transports.map(
              (transport) => TransportCard(transport: transport),
            ),
          ],
        ),
      ],
    );
  }
}
