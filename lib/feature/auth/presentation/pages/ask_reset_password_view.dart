import 'package:fiestapp/components/input/data-tag-input.component.dart';
import 'package:fiestapp/core/common_widgets/button/button.component.dart';
import 'package:fiestapp/core/network/client/api_client_provider.dart';
import 'package:fiestapp/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class AskResetPasswordView extends ConsumerStatefulWidget {
  const AskResetPasswordView({super.key});

  @override
  ConsumerState<AskResetPasswordView> createState() =>
      _AskResetPasswordViewState();
}

class _AskResetPasswordViewState extends ConsumerState<AskResetPasswordView> {
  final TextEditingController _mailController = TextEditingController();
  bool isLoading = false;

  Future<void> _submit() async {
    if (_mailController.text.isEmpty) return;

    setState(() => isLoading = true);
    try {
      final apiClient = ref.read(apiClientProvider);
      await apiClient.auth.askResetPassword(_mailController.text);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Un e-mail de réinitialisation vous a été envoyé"),
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Erreur lors de la demande"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Réinitialisation")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          spacing: 20,
          children: [
            const Text(
              "Saisissez votre adresse mail pour recevoir un lien de réinitialisation.",
              textAlign: TextAlign.center,
            ),
            DataTagInput(
              title: "E-mail",
              placeholder: "votre@mail.com",
              inputType: InputType.text,
              controller: _mailController,
              icon: FontAwesomeIcons.envelope,
            ),
            const SizedBox(height: 10),
            if (isLoading)
              const CircularProgressIndicator()
            else
              CustomButton(
                label: "Envoyer le mail",
                icon: FontAwesomeIcons.paperPlane,
                onPressed: _submit,
              ),
          ],
        ),
      ),
    );
  }
}
