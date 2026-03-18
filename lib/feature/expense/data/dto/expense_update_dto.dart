class ExpenseUpdateDto {
  final String? name;
  final double? amount;

  ExpenseUpdateDto({this.name, this.amount});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (name != null) data['name'] = name;
    if (amount != null) data['amount'] = amount;

    return data;
  }

  factory ExpenseUpdateDto.fromJson(Map<String, dynamic> json) {
    return ExpenseUpdateDto(
      name: json['name'] as String?,
      amount: json['amount'] != null
          ? (json['amount'] as num).toDouble()
          : null,
    );
  }
}
