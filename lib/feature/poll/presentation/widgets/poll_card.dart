import 'package:fiestapp/core/common_widgets/button/button.component.dart';
import 'package:fiestapp/core/network/client/api_client_provider.dart';
import 'package:fiestapp/enum.dart';
import 'package:fiestapp/feature/event/data/event_service.dart';
import 'package:fiestapp/feature/event/data/provider/event_details_state.dart';
import 'package:fiestapp/feature/poll/data/dto/poll_dto.dart';
import 'package:fiestapp/feature/poll/data/dto/vote_dto.dart';
import 'package:fiestapp/feature/poll/data/poll_service.dart';
import 'package:fiestapp/feature/poll/presentation/widgets/poll_choice.dart';
import 'package:fiestapp/feature/user/data/dto/user_light_dto.dart';
import 'package:fiestapp/feature/user/data/provider/user_state.dart';
import 'package:fiestapp/feature/user/presentation/widgets/external/avatar_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PollCard extends ConsumerStatefulWidget {
  const PollCard({super.key, required this.poll});

  final PollDto poll;

  @override
  ConsumerState<PollCard> createState() => _PollCardState();
}

class _PollCardState extends ConsumerState<PollCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  final List<String> _selectedGuids = [];
  bool _hasValidated = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkIfAlreadyVoted();
  }

  void _checkIfAlreadyVoted() {
    final userId = ref.read(userSessionProvider).user?.id;
    if (userId == null) return;

    final List<String> userVotes = [];
    for (final option in widget.poll.options) {
      if (option.votes.any((v) => v.id == userId)) {
        userVotes.add(option.id);
      }
    }

    if (userVotes.isNotEmpty) {
      setState(() {
        _hasValidated = true;
        _selectedGuids.addAll(userVotes);
      });
    }
  }

  void toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  Future<void> onValidate() async {
    if (_selectedGuids.isEmpty || _isLoading) return;

    setState(() => _isLoading = true);

    try {
      final apiClient = ref.read(apiClientProvider);
      await PollService.vote(
        apiClient: apiClient,
        dto: VotesDto(votes: _selectedGuids),
        pollId: widget.poll.id,
      );

      setState(() {
        _hasValidated = true;
        _isLoading = false;
      });

      final eventId = ref.read(eventDetailsProvider).event?.id;
      if (eventId != null) {
        final prunes = await EventService.getPrunes(
          apiClient: apiClient,
          id: eventId,
        );
        ref.read(eventDetailsProvider.notifier).setPrunes(prunes);
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Une erreur est survenue lors du vote")),
        );
      }
    }
  }

  PollChoiceStatus getStatus(String guid) {
    if (_hasValidated) {
      return _selectedGuids.contains(guid)
          ? PollChoiceStatus.validated
          : PollChoiceStatus.none;
    } else if (_selectedGuids.contains(guid)) {
      return PollChoiceStatus.selected;
    } else {
      return PollChoiceStatus.none;
    }
  }

  void _onChoiceTap(String guid) {
    setState(() {
      if (widget.poll.multiChoice) {
        if (_selectedGuids.contains(guid)) {
          _selectedGuids.remove(guid);
        } else {
          _selectedGuids.add(guid);
        }
      } else {
        _selectedGuids.clear();
        _selectedGuids.add(guid);
      }
      // Dès qu'on change la sélection, on permet de re-valider si on avait déjà validé
      _hasValidated = false;
    });
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
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: _isExpanded
              ? _buildExpandedContent(widget.poll)
              : _buildCollapsedContent(widget.poll),
        ),
      ),
    );
  }

  Widget _buildCollapsedContent(PollDto poll) {
    final List<UserLightDto> voters = poll.options
        .expand((o) => o.votes)
        .toList();
    final String usersLengthText =
        "${voters.length} participant${voters.length <= 1 ? '' : 's'}";

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              poll.question,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 5),
            AvatarGroup(
              users: voters,
              haveBackground: false,
              textColor: Colors.black,
              text: usersLengthText,
            ),
          ],
        ),
        Column(
          children: [
            const FaIcon(
              FontAwesomeIcons.hourglass,
              color: Color(0xffE15B42),
              size: 17,
            ),
            Text("${poll.timeLeft.inHours}h"),
          ],
        ),
      ],
    );
  }

  Widget _buildExpandedContent(PollDto poll) {
    final int totalVotes = poll.options.fold(0, (sum, o) => sum + o.voteCount);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCollapsedContent(poll),
        const SizedBox(height: 15),
        Column(
          children: poll.options.map((option) {
            final double percentage = totalVotes > 0
                ? option.voteCount / totalVotes
                : 0.0;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: PollChoice(
                label: option.value,
                percentage: percentage,
                status: getStatus(option.id),
                onTap: () => _onChoiceTap(option.id),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerRight,
          child: _isLoading
              ? const CircularProgressIndicator()
              : CustomButton(
                  icon: FontAwesomeIcons.arrowRight,
                  label: _hasValidated ? "Voté" : "Valider",
                  onPressed: _selectedGuids.isEmpty ? null : onValidate,
                ),
        ),
      ],
    );
  }
}
