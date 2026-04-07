import 'package:fiestapp/components/input/data-tag-input.component.dart';
import 'package:fiestapp/core/common_widgets/button/button.component.dart';
import 'package:fiestapp/core/network/client/api_client_provider.dart';
import 'package:fiestapp/core/routing/route_enum.dart';
import 'package:fiestapp/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordView extends ConsumerStatefulWidget {
  final String token;
  const ResetPasswordView({super.key, required this.token});

  @override
  ConsumerState<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends ConsumerState<ResetPasswordView> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool isLoading = false;

  Future<void> _submit() async {
    if (_passwordController.text.isEmpty ||
        _passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Les mots de passe ne correspondent pas")),
      );
      return;
    }

    setState(() => isLoading = true);
    try {
      final apiClient = ref.read(apiClientProvider);
      await apiClient.auth.updatePassword(
        widget.token,
        _passwordController.text,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Mot de passe modifié avec succès")),
        );
        context.goNamed(AppRoute.login.name);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Erreur lors de la modification"),
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
      appBar: AppBar(title: const Text("Nouveau mot de passe")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          spacing: 20,
          children: [
            const Text(
              "Saisissez votre nouveau mot de passe.",
              textAlign: TextAlign.center,
            ),
            DataTagInput(
              title: "Nouveau mot de passe",
              placeholder: "********",
              inputType: InputType.text,
              controller: _passwordController,
              icon: FontAwesomeIcons.lock,
            ),
            DataTagInput(
              title: "Confirmer le mot de passe",
              placeholder: "********",
              inputType: InputType.text,
              controller: _confirmPasswordController,
              icon: FontAwesomeIcons.lock,
            ),
            const SizedBox(height: 10),
            if (isLoading)
              const CircularProgressIndicator()
            else
              CustomButton(
                label: "Réinitialiser",
                icon: FontAwesomeIcons.check,
                onPressed: _submit,
              ),
          ],
        ),
      ),
    );
  }
}
