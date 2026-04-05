import 'package:fiestapp/components/input/data-tag-input.component.dart';
import 'package:fiestapp/core/common_widgets/button/button.component.dart';
import 'package:fiestapp/core/network/client/api_client_provider.dart';
import 'package:fiestapp/enum.dart';
import 'package:fiestapp/feature/accomodation/data/accomodation_service.dart';
import 'package:fiestapp/feature/accomodation/data/dto/accomodation_create_dto.dart';
import 'package:fiestapp/feature/event/data/event_service.dart';
import 'package:fiestapp/feature/event/data/provider/event_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class CreateSleepModal extends ConsumerStatefulWidget {
  const CreateSleepModal({super.key});

  @override
  ConsumerState<CreateSleepModal> createState() => _CreateSleepModalState();
}

class _CreateSleepModalState extends ConsumerState<CreateSleepModal> {
  final TextEditingController _placesController = TextEditingController(
    text: '1',
  );
  bool isLoading = false;

  @override
  void dispose() {
    _placesController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final event = ref.read(eventDetailsProvider).event;
    if (event == null) return;

    final places = int.tryParse(_placesController.text) ?? 0;

    if (places < 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Veuillez entrer au moins 1 place disponible"),
        ),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final apiClient = ref.read(apiClientProvider);
      final dto = AccommodationCreateDto(
        count: places,
        eventId: event.id,
      );

      await AccomodationService.create(apiClient: apiClient, dto: dto);

      // Rafraichir les données de l'event
      final prunes = await EventService.getPrunes(
        apiClient: apiClient,
        id: event.id,
      );
      ref.read(eventDetailsProvider.notifier).setPrunes(prunes);

      if (mounted) {
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Une erreur est survenue")),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.95,
        minWidth: MediaQuery.of(context).size.width * 0.95,
      ),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            const Center(
              child: Text(
                "Ajout d'un hébergement",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            DataTagInput(
              title: 'Places disponibles',
              placeholder: '1',
              inputType: InputType.counter,
              controller: _placesController,
              minValue: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (isLoading)
                  const CircularProgressIndicator()
                else
                  CustomButton(
                    label: 'Ajouter',
                    icon: FontAwesomeIcons.arrowRight,
                    onPressed: _submit,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
