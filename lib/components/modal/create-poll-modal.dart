import 'package:fiestapp/components/button/icon-button.component.dart';
import 'package:fiestapp/components/input/data-tag-input.component.dart';
import 'package:fiestapp/core/common_widgets/button/button.component.dart';
import 'package:fiestapp/core/network/client/api_client_provider.dart';
import 'package:fiestapp/enum.dart';
import 'package:fiestapp/feature/event/data/event_service.dart';
import 'package:fiestapp/feature/event/data/provider/event_details_state.dart';
import 'package:fiestapp/feature/poll/data/dto/poll_create_dto.dart';
import 'package:fiestapp/feature/poll/data/dto/poll_option_create_dto.dart';
import 'package:fiestapp/feature/poll/data/poll_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class CreatePollModal extends ConsumerStatefulWidget {
  const CreatePollModal({super.key});

  @override
  ConsumerState<CreatePollModal> createState() => _CreatePollModalState();
}

class _CreatePollModalState extends ConsumerState<CreatePollModal> {
  final TextEditingController _titleController = TextEditingController();
  final List<TextEditingController> _optionControllers = [];
  bool _isMultiChoice = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 2; i++) {
      _optionControllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    for (final controller in _optionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addOption() {
    setState(() {
      _optionControllers.add(TextEditingController());
    });
  }

  void _removeOption(int index) {
    if (_optionControllers.length > 2) {
      setState(() {
        _optionControllers[index].dispose();
        _optionControllers.removeAt(index);
      });
    }
  }

  Future<void> _submit() async {
    final event = ref.read(eventDetailsProvider).event;
    if (event == null) return;

    if (_titleController.text.isEmpty ||
        _optionControllers.any((c) => c.text.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez remplir tous les champs")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final apiClient = ref.read(apiClientProvider);
      final dto = PollCreateDto(
        question: _titleController.text,
        multiChoice: _isMultiChoice,
        duration: 24, // 24 heures par défaut
        options: _optionControllers
            .map((c) => PollOptionCreateDto(value: c.text))
            .toList(),
        eventId: event.id,
      );

      await PollService.create(apiClient: apiClient, dto: dto);

      // Rafraichir les données de l'event (prunes)
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
        maxHeight: MediaQuery.of(context).size.height * 0.8,
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
                "Ajout d'un sondage",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            DataTagInput(
              title: 'Question',
              placeholder: 'Question du sondage',
              inputType: InputType.text,
              controller: _titleController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Choix multiple",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                Switch(
                  value: _isMultiChoice,
                  activeColor: const Color(0xffE15B42),
                  onChanged: (value) {
                    setState(() {
                      _isMultiChoice = value;
                    });
                  },
                ),
              ],
            ),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    const Text(
                      "Options",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    for (int i = 0; i < _optionControllers.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 8,
                          children: [
                            Expanded(
                              child: DataTagInput(
                                title: 'Option ${i + 1}',
                                placeholder: "Valeur de l'option",
                                inputType: InputType.text,
                                controller: _optionControllers[i],
                              ),
                            ),
                            if (_optionControllers.length > 2)
                              CustomIconButton(
                                icon: FontAwesomeIcons.trash,
                                backgroundColor: Colors.white,
                                iconColor: const Color(0xffE15B42),
                                onClick: () => _removeOption(i),
                              ),
                          ],
                        ),
                      ),
                    GestureDetector(
                      onTap: _addOption,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xffE15B42,
                              ).withValues(alpha: 0.04),
                              offset: const Offset(0, 4),
                              blurRadius: 4,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: FaIcon(
                            FontAwesomeIcons.plus,
                            color: Color(0xffE15B42),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
