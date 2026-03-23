import 'package:fiestapp/components/input/data-tag-input.component.dart';
import 'package:fiestapp/core/common_widgets/button/button.component.dart';
import 'package:fiestapp/core/network/client/api_client_provider.dart';
import 'package:fiestapp/enum.dart';
import 'package:fiestapp/feature/event/data/provider/event_details_state.dart';
import 'package:fiestapp/feature/expense/data/dto/expense_create_dto.dart';
import 'package:fiestapp/feature/expense/data/expense_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class CreateExpenseModal extends ConsumerStatefulWidget {
  const CreateExpenseModal({super.key});

  @override
  ConsumerState<CreateExpenseModal> createState() => _CreateExpenseModalState();
}

class _CreateExpenseModalState extends ConsumerState<CreateExpenseModal> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _costController = TextEditingController(
    text: '0',
  );
  bool isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _costController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final event = ref.read(eventDetailsProvider).event;
    if (event == null) return;

    if (_nameController.text.isEmpty || _costController.text == '0') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez remplir tous les champs")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final apiClient = ref.read(apiClientProvider);
      final dto = ExpenseCreateDto(
        name: _nameController.text,
        amount: double.parse(_costController.text.replaceAll(',', '.')),
        eventId: event.id,
      );

      await ExpenseService.create(apiClient: apiClient, dto: dto);

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
                "Ajout d'une dépense",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            DataTagInput(
              title: 'Nom de la dépense',
              placeholder: 'Dépense',
              inputType: InputType.text,
              controller: _nameController,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 10,
              children: [
                Expanded(
                  child: DataTagInput(
                    title: 'Coût',
                    placeholder: '0',
                    inputType: InputType.number,
                    controller: _costController,
                  ),
                ),
                const FaIcon(
                  FontAwesomeIcons.euroSign,
                  color: Color(0xffE15B42),
                  size: 20,
                ),
              ],
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
