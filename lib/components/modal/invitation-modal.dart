import 'package:fiestapp/core/common_widgets/button/button.component.dart';
import 'package:fiestapp/feature/event/domain/models/event.dart';
import 'package:fiestapp/feature/user/domain/models/user.dart';
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
  @protected
  late QrImage qrImage;

  late String fullInvitationLink;

  @override
  void initState() {
    super.initState();

    // Mock de l'event
    final selectedEvent = Event(
      guid: 'event-1',
      title: 'Soirée Mock',
      description: 'Description',
      location: 'Paris',
      latitute: 48.8566,
      longitude: 2.3522,
      date: DateTime.now().millisecondsSinceEpoch,
      organizer: User(
        userGuid: 'user-1',
        username: 'Léo',
        gender: 'male',
        age: 25,
        height: 180,
        weight: 75,
        alcoholConsumption: 'casual',
        ppLink: null,
      ),
      participants: [],
      expenses: [],
    );

    fullInvitationLink = 'fiestapp://invitation/${selectedEvent.guid}';
    final qrCode = QrCode(5, QrErrorCorrectLevel.H)..addData(fullInvitationLink);
    qrImage = QrImage(qrCode);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: PrettyQrView(
              qrImage: qrImage,
              decoration: const PrettyQrDecoration(shape: PrettyQrRoundedSymbol(color: Color(0xffE15B42))),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Scanner pour rejoindre',
            style: TextStyle(color: Color(0xffE15B42), fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          const Text("Une soirée c'est bien, mais avec des invités c'est mieux !", textAlign: TextAlign.center),
          const SizedBox(height: 20),
          CustomButton(
            label: 'Copier le lien',
            icon: FontAwesomeIcons.copy,
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: fullInvitationLink));
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Lien copié avec succès")));
              }
            },
          ),
        ],
      ),
    );
  }
}
