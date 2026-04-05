import 'package:fiestapp/core/common_widgets/button/button.component.dart';
import 'package:fiestapp/core/network/client/api_client_provider.dart';
import 'package:fiestapp/feature/event/data/provider/event_details_state.dart';
import 'package:fiestapp/feature/invitation/data/invitation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class InvitationModal extends ConsumerStatefulWidget {
  const InvitationModal({super.key});

  @override
  ConsumerState<InvitationModal> createState() => _InvitationModalState();
}

class _InvitationModalState extends ConsumerState<InvitationModal> {
  String? fullInvitationLink;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadInvitation();
  }

  Future<void> _loadInvitation() async {
    final event = ref.read(eventDetailsProvider).event;
    if (event == null) return;

    setState(() => isLoading = true);

    try {
      final apiClient = ref.read(apiClientProvider);
      final invitation = await InvitationService.getOrCreate(
        apiClient: apiClient,
        eventId: event.id,
      );

      if (mounted) {
        setState(() {
          fullInvitationLink = 'fiestapp://invitation?token=${invitation.id}';
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Erreur lors de la génération du lien")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: Color(0xffE15B42)),
            SizedBox(height: 15),
            Text("Génération de l'invitation..."),
          ],
        ),
      );
    }

    if (fullInvitationLink == null) {
      return const Padding(
        padding: EdgeInsets.all(30),
        child: Text("Impossible de générer l'invitation"),
      );
    }

    // Niveau M (15%) pour simplifier le motif et faciliter la lecture
    final qrCode = QrCode.fromData(
      data: fullInvitationLink!,
      errorCorrectLevel: QrErrorCorrectLevel.M,
    );
    final qrImage = QrImage(qrCode);

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            height: 150,
            width: 150,
            child: PrettyQrView(
              qrImage: qrImage,
              decoration: const PrettyQrDecoration(
                shape: PrettyQrRoundedSymbol(color: Colors.black),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Scanner pour rejoindre',
            style: TextStyle(
              color: Color(0xffE15B42),
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Une soirée c'est bien, mais avec des invités c'est mieux !",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          CustomButton(
            label: 'Copier le lien',
            icon: FontAwesomeIcons.copy,
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: fullInvitationLink!));
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Lien copié avec succès")),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
