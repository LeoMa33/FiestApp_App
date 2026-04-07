import 'package:fiestapp/feature/user/data/dto/user_light_dto.dart';

class ExpenseDto {
  final String id;
  final String name;
  final UserLightDto author;
  final double amount;

  ExpenseDto({
    required this.id,
    required this.name,
    required this.author,
    required this.amount,
  });

  factory ExpenseDto.fromJson(Map<String, dynamic> json) {
    return ExpenseDto(
      id: json['id'].toString(),
      name: json['name'] as String? ?? '',
      author: UserLightDto.fromJson(
        (json['author'] ?? {}) as Map<String, dynamic>,
      ),
      amount: (json['amount'] is String)
          ? double.parse(json['amount'])
          : (json['amount'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'author': author.toJson(),
      'amount': amount,
    };
  }
}
