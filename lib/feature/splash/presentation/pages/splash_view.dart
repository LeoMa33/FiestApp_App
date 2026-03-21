import 'package:fiestapp/core/network/client/api_client_provider.dart';
import 'package:fiestapp/core/network/dio_provider.dart';
import 'package:fiestapp/feature/splash/domain/splash_service.dart';
import 'package:fiestapp/feature/user/data/provider/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _bootApp());
  }

  Future<void> _bootApp() async {
    const storage = FlutterSecureStorage();

    final savedToken = await storage.read(key: 'jwt_token');
    final refreshToken = await storage.read(key: 'refresh_token');

    if (savedToken != null) {
      ref.read(tokenProvider.notifier).state = savedToken;
      ref.read(refreshTokenProvider.notifier).state = refreshToken;
    }

    final result = await SplashService.checkInitialAuth(
      apiClient: ref.read(apiClientProvider),
      storage: storage,
    );

    if (result.user != null) {
      ref.read(userSessionProvider.notifier).setUser(result.user!);
    }

    if (!mounted) return;

    context.goNamed(result.route.name);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
