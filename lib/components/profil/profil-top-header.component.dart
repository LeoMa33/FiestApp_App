import 'package:fiestapp/components/button/icon-button.component.dart';
import 'package:fiestapp/core/routing/route_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class ProfilTopHeader extends ConsumerWidget {
  const ProfilTopHeader({super.key, this.allowEdit = true});

  final bool allowEdit;

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
            icon: FontAwesomeIcons.pen,
            backgroundColor: Colors.black.withValues(alpha: 0.2),
            iconColor: Colors.white,
            onClick: () => {},
          ),
      ],
    );
  }
}
