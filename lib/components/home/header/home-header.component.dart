import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fiestapp/core/common_widgets/search_bar/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'top-home-header.component.dart';

class HomeHeader extends ConsumerWidget {
  const HomeHeader({super.key, required this.userName});

  final String userName;

  String search() {
    return "Rechercher";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
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
        height: MediaQuery.sizeOf(context).height / 3.8,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            color: Color(0xFFE15B42).withValues(alpha: 0.3),
            child: SafeArea(
              minimum: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 45,
                bottom: 10,
              ),
              bottom: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TopHomeHeader(name: userName),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: CustomSearchBar(
                      icon: Icons.search,
                      placeholder: "Rechercher",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
