import 'package:fiestapp/components/input/data-tag-input.component.dart';
import 'package:fiestapp/core/common_widgets/button/button.component.dart';
import 'package:fiestapp/core/network/client/api_client_provider.dart';
import 'package:fiestapp/enum.dart';
import 'package:fiestapp/feature/event/data/event_service.dart';
import 'package:fiestapp/feature/event/data/provider/event_details_state.dart';
import 'package:fiestapp/feature/transport/data/dto/transport_create_dto.dart';
import 'package:fiestapp/feature/transport/data/transport_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class CreateTransportModal extends ConsumerStatefulWidget {
  const CreateTransportModal({super.key});

  @override
  ConsumerState<CreateTransportModal> createState() =>
      _CreateTransportModalState();
}

class _CreateTransportModalState extends ConsumerState<CreateTransportModal> {
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _placesController = TextEditingController(
    text: '1',
  );
  bool isLoading = false;

  @override
  void dispose() {
    _streetController.dispose();
    _cityController.dispose();
    _postalCodeController.dispose();
    _placesController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final event = ref.read(eventDetailsProvider).event;
    if (event == null) return;

    final places = int.tryParse(_placesController.text) ?? 0;

    if (_streetController.text.isEmpty ||
        _cityController.text.isEmpty ||
        places < 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Veuillez remplir tous les champs (min 1 place)"),
        ),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final apiClient = ref.read(apiClientProvider);
      final dto = TransportCreateDto(
        count: places,
        address:
            "${_streetController.text}, ${_postalCodeController.text} ${_cityController.text}",
        eventId: event.id,
      );

      await TransportService.create(apiClient: apiClient, dto: dto);

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
                "Ajout d'un transport",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            DataTagInput(
              title: 'Rue',
              placeholder: 'Entrer la rue',
              inputType: InputType.text,
              controller: _streetController,
            ),
            Row(
              spacing: 20,
              children: [
                Expanded(
                  child: DataTagInput(
                    title: 'Ville',
                    placeholder: 'Ville',
                    inputType: InputType.text,
                    controller: _cityController,
                  ),
                ),
                Expanded(
                  child: DataTagInput(
                    title: 'Code postal',
                    placeholder: 'Code postal',
                    inputType: InputType.number,
                    controller: _postalCodeController,
                  ),
                ),
              ],
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
