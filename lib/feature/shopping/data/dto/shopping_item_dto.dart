class ShoppingItemDto {
  final String id;
  final String name;
  final int quantity;
  final String image;
  final String eventId;

  ShoppingItemDto({
    required this.id,
    required this.name,
    required this.quantity,
    required this.image,
    required this.eventId,
  });

  factory ShoppingItemDto.fromJson(Map<String, dynamic> json) {
    return ShoppingItemDto(
      id: json['id'] as String,
      name: json['name'] as String,
      quantity: (json['quantity'] as num).toInt(),
      image: json['image'] as String,
      eventId: json['eventId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'image': image,
      'eventId': eventId,
    };
  }
}
