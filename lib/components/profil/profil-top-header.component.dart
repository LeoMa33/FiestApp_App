import 'package:fiestapp/components/button/icon-button.component.dart';
import 'package:fiestapp/core/network/dio_provider.dart';
import 'package:fiestapp/core/routing/route_enum.dart';
import 'package:fiestapp/feature/user/data/provider/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class ProfilTopHeader extends ConsumerWidget {
  const ProfilTopHeader({super.key, this.allowEdit = true});

  final bool allowEdit;

  Future<void> _disconnect(WidgetRef ref, BuildContext context) async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'jwt_token');
    await storage.delete(key: 'refresh_token');

    ref.read(tokenProvider.notifier).state = null;
    ref.read(refreshTokenProvider.notifier).state = null;
    ref.read(userSessionProvider.notifier).clear();

    if (context.mounted) {
      context.go(AppRoute.login.path);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomIconButton(
          icon: FontAwesomeIcons.arrowLeft,
          backgroundColor: Colors.black.withValues(alpha: 0.2),
          iconColor: Colors.white,
          onClick: () => context.go(AppRoute.home.path),
        ),
        if (allowEdit)
          CustomIconButton(
            icon: FontAwesomeIcons.arrowRightFromBracket,
            backgroundColor: Colors.black.withValues(alpha: 0.2),
            iconColor: Colors.red,
            onClick: () => _disconnect(ref, context),
          ),
      ],
    );
  }
}
