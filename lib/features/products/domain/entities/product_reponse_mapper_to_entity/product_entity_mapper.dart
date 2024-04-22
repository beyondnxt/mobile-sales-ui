import 'package:sales_app/core/utils/mapper/data_mapper.dart';
import 'package:sales_app/features/products/domain/entities/product_response_entity/product_entity.dart';

class ProductDataMapperToEntity extends DataMapper<ProductEntity> {
  ProductDataMapperToEntity({
    this.name,
    this.weight,
    this.totalPrice,
    this.unitPrice,
    this.quantity,
    this.totalUnitPrice,
  });

  String? name;
  String? weight;
  String? totalPrice;
  String? unitPrice;
  int? quantity;
  String? totalUnitPrice;

  @override
  ProductEntity mapToEntity() {
    return ProductEntity(
      name: name,
      weight: weight,
      totalPrice: totalPrice,
      unitPrice: unitPrice,
      quantity: quantity,
      totalUnitPrice: totalUnitPrice,
    );
  }
}
