import 'package:dio/dio.dart';
import 'package:fiestapp/core/network/client/api_client.dart';
import 'package:fiestapp/feature/expense/data/dto/expense_create_dto.dart';
import 'package:fiestapp/feature/expense/data/dto/expense_dto.dart';

class ExpenseService {
  static Future<ExpenseDto> create({
    required ApiClient apiClient,
    required ExpenseCreateDto dto,
  }) async {
    try {
      return await apiClient.expense.post(dto);
    } on DioException catch (e) {
      print(e);
      rethrow;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
