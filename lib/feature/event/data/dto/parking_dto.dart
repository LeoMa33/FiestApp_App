class ParkingDto {
  final String id;
  final String name;
  final String address;
  final String? url;
  final bool isFree;
  final int spaceCount;
  final double lon;
  final double lat;

  ParkingDto({
    required this.id,
    required this.name,
    required this.address,
    this.url,
    required this.isFree,
    required this.spaceCount,
    required this.lon,
    required this.lat,
  });

  factory ParkingDto.fromJson(Map<String, dynamic> json) {
    return ParkingDto(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      url: json['url'] as String?,
      isFree: json['isFree'] == 1 || json['isFree'] == true,
      spaceCount: (json['spaceCount'] as num).toInt(),
      lon: (json['lon'] as num).toDouble(),
      lat: (json['lat'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'url': url,
      'isFree': isFree ? 1 : 0,
      'spaceCount': spaceCount,
      'lon': lon,
      'lat': lat,
    };
  }
}
