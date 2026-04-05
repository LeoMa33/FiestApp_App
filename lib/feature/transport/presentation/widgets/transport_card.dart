import 'package:fiestapp/components/button/profil-image-button.component.dart';
import 'package:fiestapp/core/common_widgets/button/button.component.dart';
import 'package:fiestapp/core/network/client/api_client_provider.dart';
import 'package:fiestapp/core/network/s3_service.dart';
import 'package:fiestapp/feature/event/data/event_service.dart';
import 'package:fiestapp/feature/event/data/provider/event_details_state.dart';
import 'package:fiestapp/feature/transport/data/dto/transport_dto.dart';
import 'package:fiestapp/feature/transport/data/transport_service.dart';
import 'package:fiestapp/feature/user/data/provider/user_state.dart';
import 'package:fiestapp/feature/user/presentation/widgets/external/avatar_group.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TransportCard extends ConsumerStatefulWidget {
  const TransportCard({super.key, required this.transport});

  final TransportDto transport;

  @override
  ConsumerState<TransportCard> createState() => _TransportCardState();
}

class _TransportCardState extends ConsumerState<TransportCard>
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

    final isPassenger = widget.transport.passengers.any((g) => g.id == user.id);
    final isFull = widget.transport.passengers.length >= widget.transport.count;

    if (!isPassenger && isFull) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Ce transport est complet")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final apiClient = ref.read(apiClientProvider);
      if (isPassenger) {
        await TransportService.leave(
          apiClient: apiClient,
          id: widget.transport.id,
        );
      } else {
        await TransportService.join(
          apiClient: apiClient,
          id: widget.transport.id,
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
              ? _buildExpandedContent(widget.transport)
              : _buildCollapsedContent(widget.transport),
        ),
      ),
    );
  }

  Widget _buildCollapsedContent(TransportDto transport) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              ProfilImageButton(
                imagePath: S3Service.getUserImage(transport.driver.imageUrl),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transport.driver.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
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
                            transport.address,
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 12,
                              color: Colors.grey,
                            ),
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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xffE15B42).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            "🚗 ${transport.passengers.length}/${transport.count}",
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

  Widget _buildExpandedContent(TransportDto transport) {
    final user = ref.watch(userSessionProvider).user;
    final isPassenger =
        user != null && transport.passengers.any((g) => g.id == user.id);
    final isDriver = user != null && transport.driver.id == user.id;
    final isFull = transport.passengers.length >= transport.count;

    final String usersLengthText =
        "${transport.passengers.length} participant${transport.passengers.length <= 1 ? '' : 's'}";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCollapsedContent(transport),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AvatarGroup(
              users: transport.passengers,
              haveBackground: false,
              textColor: Colors.black,
              text: usersLengthText,
            ),
            if (!isDriver)
              _isLoading
                  ? const Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: CupertinoActivityIndicator(),
                    )
                  : CustomButton(
                      icon: isPassenger
                          ? FontAwesomeIcons.xmark
                          : FontAwesomeIcons.check,
                      label: isPassenger ? "Quitter" : "Rejoindre",
                      onPressed:
                          (!isPassenger && isFull) ? null : _handleJoinLeave,
                    ),
          ],
        ),
      ],
    );
  }
}
