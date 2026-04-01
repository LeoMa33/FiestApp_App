class TransportUpdateDto {
  final int? count;
  final String? address;

  TransportUpdateDto({this.count, this.address});

  Map<String, dynamic> toJson() {
    return {
      if (count != null) 'count': count,
      if (address != null) 'address': address,
    };
  }

  factory TransportUpdateDto.fromJson(Map<String, dynamic> json) {
    return TransportUpdateDto(
      count: json['count'] != null ? (json['count'] as num).toInt() : null,
      address: json['address'] as String?,
    );
  }
}
