import 'package:fiestapp/feature/user/domain/models/user.dart';

class Expense {
  final String guid;
  final User payer;
  final String label;
  final double amount;

  Expense({
    required this.guid,
    required this.payer,
    required this.label,
    required this.amount,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      guid: json['id'] as String,
      payer: User.fromJson(json['payer']),
      label: json['label'] as String,
      amount: (json['amount'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': guid,
      'payer': payer.toJson(),
      'label': label,
      'amount': amount,
    };
  }
}
