import 'package:dio/dio.dart';
import 'package:fiestapp/core/network/client/api_client.dart';
import 'package:fiestapp/feature/shopping/data/dto/shopping_item_create_dto.dart';
import 'package:fiestapp/feature/shopping/data/dto/shopping_item_dto.dart';

class ShoppingItemService {
  static Future<ShoppingItemDto> create({
    required ApiClient apiClient,
    required ShoppingItemCreateDto dto,
  }) async {
    try {
      return await apiClient.shoppingItem.post(dto);
    } on DioException catch (e) {
      print(e);
      rethrow;
    }
  }
}
