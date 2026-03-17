import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fiestapp/components/profil/profil-top-header.component.dart';
import 'package:fiestapp/constant.dart';
import 'package:fiestapp/provider/user.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openapi/openapi.dart';

class ProfilHeader extends ConsumerWidget {
  const ProfilHeader({super.key, this.allowEdit = true});

  final bool allowEdit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User? currentUser = ref.watch(userProvider);

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
                  image: CachedNetworkImageProvider(
                    'https://images.unsplash.com/photo-1517457373958-b7bdd4587205?q=80&w=1169&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  ),
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
                  "${S3_enpoint}user/${currentUser?.guid}.webp",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
