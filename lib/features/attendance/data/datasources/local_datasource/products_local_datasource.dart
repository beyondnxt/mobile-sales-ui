import 'package:sales_app/features/products/domain/entities/product_response_entity/product_entity.dart';

abstract class AttendanceDataSource {
  Future<List<ProductEntity>?> getAllProducts();
}
