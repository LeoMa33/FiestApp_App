import 'package:fiestapp/components/button/icon-button.component.dart';
import 'package:fiestapp/core/routing/route_enum.dart';
import 'package:fiestapp/core/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilTopHeader extends ConsumerWidget {
  const ProfilTopHeader({super.key, this.allowEdit = true});

  final bool allowEdit;

  void goBack(WidgetRef ref) {
    ref.read(routerProvider).push(AppRoute.home.path);
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
          onClick: () => goBack(ref),
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
