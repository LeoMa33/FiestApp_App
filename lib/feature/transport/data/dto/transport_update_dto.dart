class TransportUpdateDto {
  final int? count;

  TransportUpdateDto({this.count});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (count != null) {
      data['count'] = count;
    }

    return data;
  }

  factory TransportUpdateDto.fromJson(Map<String, dynamic> json) {
    return TransportUpdateDto(
      count: json['count'] != null ? (json['count'] as num).toInt() : null,
    );
  }
}
