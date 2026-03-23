import 'package:fiestapp/feature/accomodation/data/dto/accomodation_dto.dart';
import 'package:fiestapp/feature/expense/data/dto/expense_dto.dart';
import 'package:fiestapp/feature/poll/data/dto/poll_dto.dart';
import 'package:fiestapp/feature/shopping/data/dto/shopping_item_dto.dart';
import 'package:fiestapp/feature/transport/data/dto/transport_dto.dart';

class PrunesDto {
  final List<AccommodationDto> accomodations;
  final List<ExpenseDto> expenses;
  final List<TransportDto> transports;
  final List<ShoppingItemDto> shoppingItems;
  final List<PollDto> polls;

  PrunesDto({
    required this.accomodations,
    required this.expenses,
    required this.transports,
    required this.shoppingItems,
    required this.polls,
  });

  factory PrunesDto.fromJson(Map<String, dynamic> json) {
    return PrunesDto(
      accomodations: (json['accomodations'] as List? ?? [])
          .map((e) => AccommodationDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      expenses: (json['expenses'] as List? ?? [])
          .map((e) => ExpenseDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      transports: (json['transports'] as List? ?? [])
          .map((e) => TransportDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      shoppingItems: (json['shoppingItems'] as List? ?? [])
          .map((e) => ShoppingItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      polls: (json['polls'] as List? ?? [])
          .map((e) => PollDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accomodations': accomodations.map((e) => e.toJson()).toList(),
      'expenses': expenses.map((e) => e.toJson()).toList(),
      'transports': transports.map((e) => e.toJson()).toList(),
      'shoppingItems': shoppingItems.map((e) => e.toJson()).toList(),
      'polls': polls.map((e) => e.toJson()).toList(),
    };
  }
}
