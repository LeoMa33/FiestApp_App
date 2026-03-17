import 'package:fiestapp/feature/user/domain/models/user.dart';

class ShoppingItem {
  final String guid;
  final String listGuid;
  final String name;
  final int quantity;
  final User assignedTo;
  final bool isBought;

  ShoppingItem({
    required this.guid,
    required this.listGuid,
    required this.name,
    required this.quantity,
    required this.assignedTo,
    required this.isBought,
  });

  factory ShoppingItem.fromJson(Map<String, dynamic> json) {
    return ShoppingItem(
      guid: json['id'] as String,
      listGuid: json['list_id'] as String,
      name: json['name'] as String,
      quantity: json['quantity'] as int,
      assignedTo: User.fromJson(json['assigned_to']),
      isBought: json['is_bought'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': guid,
      'list_id': listGuid,
      'name': name,
      'quantity': quantity,
      'assigned_to': assignedTo.toJson(),
      'is_bought': isBought,
    };
  }
}
