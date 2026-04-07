class LocationDto {
  final double lat;
  final double long;

  LocationDto({required this.lat, required this.long});

  Map<String, dynamic> toJson() {
    return {'lat': lat, 'long': long};
  }

  factory LocationDto.fromJson(Map<String, dynamic> json) {
    return LocationDto(
      lat: (json['lat'] is String)
          ? double.parse(json['lat'])
          : (json['lat'] as num).toDouble(),
      long: (json['long'] is String)
          ? double.parse(json['long'])
          : (json['long'] as num).toDouble(),
    );
  }
}
