class ShoppingItemCreateDto {
  final String name;
  final int quantity;
  final String image;
  final String eventId;

  ShoppingItemCreateDto({
    required this.name,
    required this.quantity,
    required this.image,
    required this.eventId,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'image': image,
      'eventId': eventId,
    };
  }

  factory ShoppingItemCreateDto.fromJson(Map<String, dynamic> json) {
    return ShoppingItemCreateDto(
      name: json['name'] as String,
      quantity: (json['quantity'] as num).toInt(),
      image: json['image'] as String,
      eventId: json['eventId'] as String,
    );
  }
}
