class AccommodationUpdateDto {
  final int? count;
  final String? address;

  AccommodationUpdateDto({this.count, this.address});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (count != null) data['count'] = count;
    if (address != null) data['address'] = address;

    return data;
  }
}
