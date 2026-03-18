class ShoppingItemUpdateDto {
  final String? name;
  final int? quantity;
  final String? image;

  ShoppingItemUpdateDto({this.name, this.quantity, this.image});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (name != null) data['name'] = name;
    if (quantity != null) data['quantity'] = quantity;
    if (image != null) data['image'] = image;

    return data;
  }

  factory ShoppingItemUpdateDto.fromJson(Map<String, dynamic> json) {
    return ShoppingItemUpdateDto(
      name: json['name'] as String?,
      quantity: json['quantity'] != null
          ? (json['quantity'] as num).toInt()
          : null,
      image: json['image'] as String?,
    );
  }
}
