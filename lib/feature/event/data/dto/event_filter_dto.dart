class EventFilterDto {
  final String? organizer;
  final bool? today;
  final DateTime? afterDate;
  final DateTime? beforeDate;

  EventFilterDto({this.organizer, this.today, this.afterDate, this.beforeDate});

  Map<String, dynamic> toJson() {
    return {
      if (organizer != null) 'organizer': organizer,
      if (today != null) 'today': today,
      if (afterDate != null) 'afterDate': afterDate!.toIso8601String(),
      if (beforeDate != null) 'beforeDate': beforeDate!.toIso8601String(),
    };
  }
}
