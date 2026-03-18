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
      beer: json['beer'] as int,
      pizza: json['pizza'] as int,
      softDrink: json['soft_drink'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {'beer': beer, 'pizza': pizza, 'soft_drink': softDrink};
  }
}
