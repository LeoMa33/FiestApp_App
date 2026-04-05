class EstimationDto {
  final int beer;
  final int pizza;
  final int softDrink;

  EstimationDto({
    required this.beer,
    required this.pizza,
    required this.softDrink,
  });

  factory EstimationDto.fromJson(Map<String, dynamic> json) {
    return EstimationDto(
      beer: (json['beer'] ?? 0) as int,
      pizza: (json['pizza'] ?? 0) as int,
      softDrink: (json['soft_drink'] ?? 0) as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {'beer': beer, 'pizza': pizza, 'soft_drink': softDrink};
  }
}
