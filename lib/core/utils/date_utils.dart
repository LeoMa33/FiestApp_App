import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  final year = date.year;
  return "$day/$month/$year";
}

String formatHour(DateTime date) {
  final hour = date.hour.toString().padLeft(2, '0');
  return hour;
}

String getMonthName(DateTime date) {
  final monthName = DateFormat.MMMM('fr_FR').format(date);

  if (monthName.length > 4) {
    return '${monthName.substring(0, 3)}.';
  } else {
    return monthName;
  }
}
