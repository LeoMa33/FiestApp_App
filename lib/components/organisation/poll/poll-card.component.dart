import 'package:fiestapp/components/avatar-group/avatar-group.component.dart';
import 'package:fiestapp/components/organisation/poll/poll-choice.composent.dart';
import 'package:fiestapp/core/common_widgets/button/button.component.dart';
import 'package:fiestapp/enum.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:openapi/openapi.dart';

class SondageCard extends StatefulWidget {
  const SondageCard({super.key, required this.poll});

  final Poll poll;

  @override
  State<SondageCard> createState() => _SondageCardState();
}

class _SondageCardState extends State<SondageCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  String? _selected;
  bool _hasValidated = false;

  void toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void onValidate() {
    if (_selected != null) {
      setState(() {
        _hasValidated = true;
      });
    }
  }

  PollChoiceStatus getStatus(String value) {
    if (_hasValidated) {
      return _selected == value
          ? PollChoiceStatus.validated
          : PollChoiceStatus.none;
    } else if (_selected == value) {
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
          ),
          child: _isExpanded
              ? _buildExpandedContent()
              : _buildCollapsedContent(),
        ),
      ),
    );
  }

  Widget _buildCollapsedContent() {
    final String usersLengthText =
        "${widget.poll.votes} participant${widget.poll.votes.length == 1 ? '' : 's'}";
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          spacing: 5,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Kilian marchera t-il sur une huitre ?",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
            AvatarGroup(
              users: widget.poll.votes.map((v) => v.user).toList(),
              haveBackground: false,
              textColor: Colors.black,
              text: usersLengthText,
            ),
          ],
        ),
        Column(
          children: const [
            FaIcon(
              FontAwesomeIcons.hourglass,
              color: Color(0xffE15B42),
              size: 17,
            ),
            Text("10h"),
          ],
        ),
      ],
    );
  }

  Widget _buildExpandedContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 15,
      children: [
        const Text(
          "Je suis autre sondage ?",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        Column(
          spacing: 10,
          children: ["Oui", "Non"].map((option) {
            return PollChoice(
              label: option,
              percentage: option == "Oui" ? 0.72 : 0.28,
              status: getStatus(option),
              onTap: () {
                if (!_hasValidated) {
                  setState(() {
                    _selected = option;
                  });
                }
              },
            );
          }).toList(),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: CustomButton(
            icon: FontAwesomeIcons.arrowRight,
            label: "Valider",
            onPressed: _selected == null ? null : onValidate,
          ),
        ),
      ],
    );
  }
}
