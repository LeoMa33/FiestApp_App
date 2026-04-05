import 'package:dio/dio.dart';
import 'package:fiestapp/core/common_widgets/button/button.component.dart';
import 'package:fiestapp/core/network/client/api_client_provider.dart';
import 'package:fiestapp/core/network/dio_provider.dart';
import 'package:fiestapp/core/routing/route_enum.dart';
import 'package:fiestapp/feature/auth/data/auth_service.dart';
import 'package:fiestapp/feature/auth/data/dto/auth_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  Future<void> register() async {
    if (_passwordController.text != _passwordConfirmController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Les mots de passe ne correspondent pas')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      const storage = FlutterSecureStorage();
      final apiClient = ref.read(apiClientProvider);

      await AuthService.register(
        apiClient: apiClient,
        storage: storage,
        dto: AuthDto(
          mail: _emailController.text,
          password: _passwordController.text,
        ),
      );

      final savedToken = await storage.read(key: 'jwt_token');
      final refreshToken = await storage.read(key: 'refresh_token');

      if (savedToken != null) {
        ref.read(tokenProvider.notifier).state = savedToken;
        ref.read(refreshTokenProvider.notifier).state = refreshToken;

        try {
          await apiClient.users.getMe();
        } on DioException catch (e) {
          if (e.response?.statusCode == 404) {
            if (mounted) {
              context.goNamed(AppRoute.createprofile.name);
            }
          } else {
            rethrow;
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Erreur lors de l'inscription")),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/appicon.png',
                height: 120,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 30),
              const Text(
                "S'enregistrer",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 30),
              // Champ Email
              _buildTextField(
                controller: _emailController,
                hintText: 'Email',
                enabled: !_isLoading,
              ),
              const SizedBox(height: 15),
              // Champ Mot de passe
              _buildTextField(
                controller: _passwordController,
                hintText: 'Mot de passe',
                obscureText: true,
                enabled: !_isLoading,
              ),
              const SizedBox(height: 15),
              // Champ Confirmation
              _buildTextField(
                controller: _passwordConfirmController,
                hintText: 'Confirmer le mot de passe',
                obscureText: true,
                enabled: !_isLoading,
              ),
              const SizedBox(height: 30),
              // Bouton S'enregistrer
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  label: "S'enregistrer",
                  isLoading: _isLoading,
                  onPressed: _isLoading ? null : register,
                ),
              ),
              const SizedBox(height: 20),
              // Inscription
              const Text(
                "Vous avez un compte ?",
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
              GestureDetector(
                onTap: _isLoading
                    ? null
                    : () {
                        context.replaceNamed(AppRoute.login.name);
                      },
                child: const Text(
                  "Connectez-vous",
                  style: TextStyle(
                    color: Color(0xffE15B42),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    bool enabled = true,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        enabled: enabled,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
