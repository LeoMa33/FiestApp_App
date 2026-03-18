import 'package:dio/dio.dart';
import 'package:fiestapp/feature/shopping/data/dto/shopping_item_create_dto.dart';
import 'package:fiestapp/feature/shopping/data/dto/shopping_item_dto.dart';
import 'package:fiestapp/feature/shopping/data/dto/shopping_item_update_dto.dart';

class ShoppingItemModule {
  final Dio _dio;
  final String baseRoute = '/shopping-item';

  ShoppingItemModule(this._dio);

  Future<List<ShoppingItemDto>> getAll() async {
    final response = await _dio.get(baseRoute);
    final List<dynamic> data = response.data;
    return data.map((json) => ShoppingItemDto.fromJson(json)).toList();
  }

  Future<ShoppingItemDto> getById(String id) async {
    final response = await _dio.get('$baseRoute/$id');
    return ShoppingItemDto.fromJson(response.data);
  }

  Future<ShoppingItemDto> post(ShoppingItemCreateDto dto) async {
    final response = await _dio.post(baseRoute, data: dto.toJson());
    return ShoppingItemDto.fromJson(response.data);
  }

  Future<ShoppingItemDto> patch(String id, ShoppingItemUpdateDto dto) async {
    final response = await _dio.patch('$baseRoute/$id', data: dto.toJson());
    return ShoppingItemDto.fromJson(response.data);
  }

  Future<void> delete(String id) async {
    await _dio.delete('$baseRoute/$id');
  }
}
