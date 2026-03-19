import 'package:fiestapp/components/avatar-group/avatar-group.component.dart';
import 'package:fiestapp/components/organisation/poll/poll-choice.composent.dart';
import 'package:fiestapp/core/common_widgets/button/button.component.dart';
import 'package:fiestapp/enum.dart';
import 'package:fiestapp/feature/poll/domain/models/poll.dart';
import 'package:fiestapp/feature/user/domain/models/user.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SondageCard extends StatefulWidget {
  const SondageCard({super.key, required this.poll});

  final Poll poll;

  @override
  State<SondageCard> createState() => _SondageCardState();
}

class _SondageCardState extends State<SondageCard> with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  String? _selectedGuid;
  bool _hasValidated = false;

  void toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void onValidate() {
    if (_selectedGuid != null) {
      setState(() {
        _hasValidated = true;
      });
    }
  }

  PollChoiceStatus getStatus(String guid) {
    if (_hasValidated) {
      return _selectedGuid == guid ? PollChoiceStatus.validated : PollChoiceStatus.none;
    } else if (_selectedGuid == guid) {
      return PollChoiceStatus.selected;
    } else {
      return PollChoiceStatus.none;
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
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
          ),
          child: _isExpanded ? _buildExpandedContent() : _buildCollapsedContent(),
        ),
      ),
    );
  }

  Widget _buildCollapsedContent() {
    // Mock des participants pour l'affichage
    final List<User> mockVoters = [
      User(
        userGuid: 'u1',
        username: 'User 1',
        gender: 'M',
        age: 20,
        height: 170,
        weight: 60,
        alcoholConsumption: 'casual',
        ppLink: null,
      ),
      User(
        userGuid: 'u2',
        username: 'User 2',
        gender: 'F',
        age: 22,
        height: 165,
        weight: 55,
        alcoholConsumption: 'casual',
        ppLink: null,
      ),
    ];

    final String usersLengthText = "${mockVoters.length} participant${mockVoters.length <= 1 ? '' : 's'}";

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.poll.question, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 5),
            AvatarGroup(users: mockVoters, haveBackground: false, textColor: Colors.black, text: usersLengthText),
          ],
        ),
        Column(
          children: const [
            FaIcon(FontAwesomeIcons.hourglass, color: Color(0xffE15B42), size: 17),
            Text("10h"),
          ],
        ),
      ],
    );
  }

  Widget _buildExpandedContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.poll.question, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        const SizedBox(height: 15),
        Column(
          children: widget.poll.pollOptions.map((option) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: PollChoice(
                label: option.option,
                percentage: 0.5, // Mock pourcentage
                status: getStatus(option.guid),
                onTap: () {
                  if (!_hasValidated) {
                    setState(() {
                      _selectedGuid = option.guid;
                    });
                  }
                },
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerRight,
          child: CustomButton(
            icon: FontAwesomeIcons.arrowRight,
            label: "Valider",
            onPressed: _selectedGuid == null ? null : onValidate,
          ),
        ),
      ],
    );
  }
}
