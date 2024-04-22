import 'package:json_annotation/json_annotation.dart';
import 'package:sales_app/core/utils/mapper/data_mapper.dart';
import 'package:sales_app/features/products/domain/entities/product_response_entity/product_entity.dart';

part 'product_model.g.dart';

@JsonSerializable()
class Product extends DataMapper<ProductEntity> {
  final String name;
  final String weight;
  final String totalPrice;
  final String unitPrice;
  final int quantity;
  final String totalUnitPrice;

  Product({
    required this.name,
    required this.weight,
    required this.totalPrice,
    required this.unitPrice,
    required this.quantity,
    required this.totalUnitPrice,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
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
