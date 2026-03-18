class VotesDto {
  final List<String> votes;

  VotesDto({required this.votes});

  Map<String, dynamic> toJson() {
    return {'votes': votes};
  }

  factory VotesDto.fromJson(Map<String, dynamic> json) {
    return VotesDto(votes: List<String>.from(json['votes'] as List));
  }
}
