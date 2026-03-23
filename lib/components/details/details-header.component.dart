import 'package:cached_network_image/cached_network_image.dart';
import 'package:fiestapp/components/button/icon-button.component.dart';
import 'package:fiestapp/components/modal/invitation-modal.dart';
import 'package:fiestapp/constant.dart';
import 'package:fiestapp/core/routing/route_enum.dart';
import 'package:fiestapp/feature/event/data/provider/event_details_state.dart';
import 'package:fiestapp/feature/user/presentation/widgets/external/avatar_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class DetailsHeader extends ConsumerWidget {
  const DetailsHeader({super.key, required this.height});

  final double height;

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(content: InvitationModal());
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(eventDetailsProvider);
    final event = state.event;

    if (event == null) return const SizedBox();

    final String usersLengthText =
        "${event.participants.length} participant${event.participants.length == 1 ? '' : 's'}";

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(40),
        bottomRight: Radius.circular(40),
      ),
      child: CachedNetworkImage(
        imageUrl:
            event.imageUrl ??
            'https://tripxl.com/blog/wp-content/uploads/2024/09/Subsix-Underwater-Nightclub-Niyama-Private-Islands.jpg',
        width: double.infinity,
        height: height,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          width: double.infinity,
          height: height,
          color: Colors.grey.shade200,
          child: const Center(child: CircularProgressIndicator()),
        ),
        errorWidget: (context, url, error) => Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(AppImage.defaultEventImage),
              fit: BoxFit.cover,
            ),
          ),
          child: headerContent(context, usersLengthText, event, ref),
        ),
        imageBuilder: (context, imageProvider) => Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
          child: headerContent(context, usersLengthText, event, ref),
        ),
      ),
    );
  }

  Widget headerContent(
    BuildContext context,
    String usersLengthText,
    dynamic event,
    WidgetRef ref,
  ) {
    return SafeArea(
      minimum: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 45),
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomIconButton(
                icon: FontAwesomeIcons.arrowLeft,
                backgroundColor: Colors.black.withOpacity(0.2),
                iconColor: Colors.white,
                onClick: () => context.goNamed(AppRoute.home.name),
              ),
              Row(
                children: [
                  CustomIconButton(
                    icon: FontAwesomeIcons.userPlus,
                    backgroundColor: Colors.black.withOpacity(0.2),
                    iconColor: Colors.white,
                    onClick: () => _dialogBuilder(context),
                  ),
                  const SizedBox(width: 8),
                  CustomIconButton(
                    icon: FontAwesomeIcons.pen,
                    backgroundColor: Colors.black.withOpacity(0.2),
                    iconColor: Colors.white,
                    onClick: () {},
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AvatarGroup(
                users: event.participants.toList(),
                haveBackground: true,
                textColor: Colors.white,
                text: usersLengthText,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
