class ExpenseCreateDto {
  final String name;
  final double amount;
  final String eventId;

  ExpenseCreateDto({
    required this.name,
    required this.amount,
    required this.eventId,
  });

  Map<String, dynamic> toJson() {
    return {'name': name, 'amount': amount, 'eventId': eventId};
  }

  factory ExpenseCreateDto.fromJson(Map<String, dynamic> json) {
    return ExpenseCreateDto(
      name: json['name'] as String,
      amount: (json['amount'] as num).toDouble(),
      eventId: json['eventId'] as String,
    );
  }
}
