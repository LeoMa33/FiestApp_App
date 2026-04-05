import 'package:dio/dio.dart';
import 'package:fiestapp/core/common_widgets/button/button.component.dart';
import 'package:fiestapp/core/network/client/api_client_provider.dart';
import 'package:fiestapp/core/network/dio_provider.dart';
import 'package:fiestapp/core/routing/route_enum.dart';
import 'package:fiestapp/feature/auth/data/auth_service.dart';
import 'package:fiestapp/feature/auth/data/dto/auth_dto.dart';
import 'package:fiestapp/feature/user/data/provider/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      const storage = FlutterSecureStorage();
      final apiClient = ref.read(apiClientProvider);

      await AuthService.login(
        apiClient: apiClient,
        storage: storage,
        dto: AuthDto(
          mail: _emailController.text,
          password: _passwordController.text,
        ),
      );

      final savedToken = await storage.read(key: 'jwt_token');
      final refreshToken = await storage.read(key: 'refresh_token');

      ref.read(tokenProvider.notifier).state = savedToken;
      ref.read(refreshTokenProvider.notifier).state = refreshToken;

      final user = await AuthService.getMe(
        apiClient: apiClient,
        storage: storage,
      );

      if (mounted && user != null) {
        ref.read(userSessionProvider.notifier).setUser(user);
        context.goNamed(AppRoute.home.name);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        if (mounted) {
          context.goNamed(AppRoute.createprofile.name);
        }
      }
    } catch (e) {
      if (mounted) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erreur lors de la connexion')),
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
                'Se connecter',
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
              const SizedBox(height: 10),
              // Mot de passe oublié
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _isLoading ? null : () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Mot de passe oublié ?',
                    style: TextStyle(color: Color(0xffE15B42), fontSize: 13),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Bouton Se Connecter
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  label: 'Se connecter',
                  isLoading: _isLoading,
                  onPressed: _isLoading ? null : login,
                ),
              ),
              const SizedBox(height: 20),
              // Inscription
              const Text(
                "Vous n'avez pas de compte?",
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
              GestureDetector(
                onTap: _isLoading
                    ? null
                    : () {
                        context.replaceNamed(AppRoute.register.name);
                      },
                child: const Text(
                  "S'inscrire",
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
