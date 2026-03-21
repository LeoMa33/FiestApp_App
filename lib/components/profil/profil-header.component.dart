import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fiestapp/components/profil/profil-top-header.component.dart';
import 'package:fiestapp/core/network/s3_service.dart';
import 'package:fiestapp/feature/user/data/provider/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constant.dart';

class ProfilHeader extends ConsumerWidget {
  const ProfilHeader({super.key, this.allowEdit = true});

  final bool allowEdit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.read(userSessionProvider).user;

    return SizedBox(
      height: MediaQuery.sizeOf(context).height / 3.8,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(AppImage.defaultEventImage),
                  fit: BoxFit.cover,
                ),
              ),
              width: double.infinity,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  color: Color(0xffE15B42).withValues(alpha: 0.3),
                  child: SafeArea(
                    minimum: EdgeInsets.only(top: 45, left: 10, right: 10),
                    bottom: false,
                    child: Column(
                      children: [ProfilTopHeader(allowEdit: allowEdit)],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -45,
            right: 0,
            left: 0,
            child: CircleAvatar(
              radius: 66.5,
              backgroundColor: Color(0xffF4F1F7),
              child: CircleAvatar(
                radius: 61.5,
                backgroundImage: CachedNetworkImageProvider(
                  S3Service.getUserImage(currentUser?.imageUrl),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
