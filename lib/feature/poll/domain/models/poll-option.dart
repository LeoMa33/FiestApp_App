class PollOption {
  final String guid;
  final String pollGuid;
  final String option;

  PollOption({
    required this.guid,
    required this.pollGuid,
    required this.option,
  });

  factory PollOption.fromJson(Map<String, dynamic> json) {
    return PollOption(
      guid: json['id'] as String,
      pollGuid: json['poll_id'] as String,
      option: json['option'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': guid, 'poll_id': pollGuid, 'option': option};
  }
}
