import 'package:dio/dio.dart';
import 'package:fiestapp/feature/expense/data/dto/expense_create_dto.dart';
import 'package:fiestapp/feature/expense/data/dto/expense_dto.dart';
import 'package:fiestapp/feature/expense/data/dto/expense_update_dto.dart';

class ExpenseModule {
  final Dio _dio;
  final String baseRoute = '/expense';

  ExpenseModule(this._dio);

  Future<List<ExpenseDto>> getAll() async {
    final response = await _dio.get(baseRoute);
    final List<dynamic> data = response.data;
    return data.map((json) => ExpenseDto.fromJson(json)).toList();
  }

  Future<ExpenseDto> getById(String id) async {
    final response = await _dio.get('$baseRoute/$id');
    return ExpenseDto.fromJson(response.data);
  }

  Future<ExpenseDto> post(ExpenseCreateDto dto) async {
    final response = await _dio.post(baseRoute, data: dto.toJson());
    return ExpenseDto.fromJson(response.data);
  }

  Future<ExpenseDto> patch(String id, ExpenseUpdateDto dto) async {
    final response = await _dio.patch('$baseRoute/$id', data: dto.toJson());
    return ExpenseDto.fromJson(response.data);
  }

  Future<void> delete(String id) async {
    await _dio.delete('$baseRoute/$id');
  }
}
