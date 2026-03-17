class Suggestion {
  final int beer;
  final int soft;
  final int pizza;

  Suggestion({required this.beer, required this.soft, required this.pizza});

  factory Suggestion.fromJson(Map<String, dynamic> json) {
    return Suggestion(
      beer: json['beer'] as int,
      soft: json['softBottle'] as int,
      pizza: json['pizza'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {'beer': beer, 'softBottle': soft, 'pizza': pizza};
  }
}
