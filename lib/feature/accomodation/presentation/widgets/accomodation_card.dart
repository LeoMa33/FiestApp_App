import 'package:fiestapp/components/button/profil-image-button.component.dart';
import 'package:fiestapp/core/common_widgets/button/button.component.dart';
import 'package:fiestapp/core/network/client/api_client_provider.dart';
import 'package:fiestapp/core/network/s3_service.dart';
import 'package:fiestapp/feature/accomodation/data/accomodation_service.dart';
import 'package:fiestapp/feature/accomodation/data/dto/accomodation_dto.dart';
import 'package:fiestapp/feature/event/data/event_service.dart';
import 'package:fiestapp/feature/event/data/provider/event_details_state.dart';
import 'package:fiestapp/feature/user/data/provider/user_state.dart';
import 'package:fiestapp/feature/user/presentation/widgets/external/avatar_group.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AccomodationCard extends ConsumerStatefulWidget {
  const AccomodationCard({super.key, required this.accomodation});

  final AccommodationDto accomodation;

  @override
  ConsumerState<AccomodationCard> createState() => _AccomodationCardState();
}

class _AccomodationCardState extends ConsumerState<AccomodationCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  bool _isLoading = false;

  void toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  Future<void> _handleJoinLeave() async {
    final user = ref.read(userSessionProvider).user;
    if (user == null) return;

    final isGuest = widget.accomodation.guests.any((g) => g.id == user.id);
    final isFull =
        widget.accomodation.guests.length >= widget.accomodation.count;

    if (!isGuest && isFull) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cet hébergement est complet")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final apiClient = ref.read(apiClientProvider);
      if (isGuest) {
        await AccomodationService.leave(
          apiClient: apiClient,
          id: widget.accomodation.id,
        );
      } else {
        await AccomodationService.join(
          apiClient: apiClient,
          id: widget.accomodation.id,
        );
      }

      // Refresh prunes to update the list
      final eventId = ref.read(eventDetailsProvider).event?.id;
      if (eventId != null) {
        final prunes = await EventService.getPrunes(
          apiClient: apiClient,
          id: eventId,
        );
        ref.read(eventDetailsProvider.notifier).setPrunes(prunes);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Une erreur est survenue")),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleExpand,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: _isExpanded
              ? _buildExpandedContent(widget.accomodation)
              : _buildCollapsedContent(widget.accomodation),
        ),
      ),
    );
  }

  Widget _buildCollapsedContent(AccommodationDto accomodation) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              ProfilImageButton(
                imagePath: S3Service.getUserImage(accomodation.host.imageUrl),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      accomodation.host.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 14,
                          color: Color(0xffE15B42),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            accomodation.address ?? "Adresse non renseignée",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xffE15B42).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            "🛏️ ${accomodation.guests.length}/${accomodation.count}",
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xffE15B42),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExpandedContent(AccommodationDto accomodation) {
    final user = ref.watch(userSessionProvider).user;
    final isGuest =
        user != null && accomodation.guests.any((g) => g.id == user.id);
    final isHost = user != null && accomodation.host.id == user.id;
    final isFull = accomodation.guests.length >= accomodation.count;

    final String usersLengthText =
        "${accomodation.guests.length} participant${accomodation.guests.length <= 1 ? '' : 's'}";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCollapsedContent(accomodation),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AvatarGroup(
              users: accomodation.guests,
              haveBackground: false,
              textColor: Colors.black,
              text: usersLengthText,
            ),
            if (!isHost)
              _isLoading
                  ? const Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: CupertinoActivityIndicator(),
                    )
                  : CustomButton(
                      icon: isGuest
                          ? FontAwesomeIcons.xmark
                          : FontAwesomeIcons.check,
                      label: isGuest ? "Quitter" : "Rejoindre",
                      onPressed: (!isGuest && isFull) ? null : _handleJoinLeave,
                    ),
          ],
        ),
      ],
    );
  }
}
