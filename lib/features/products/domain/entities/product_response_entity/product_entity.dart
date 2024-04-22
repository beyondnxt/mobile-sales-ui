import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  const ProductEntity({
    this.name,
    this.weight,
    this.totalPrice,
    this.unitPrice,
    this.quantity,
    this.totalUnitPrice,
  });
  final String? name;
  final String? weight;
  final String? totalPrice;
  final String? unitPrice;
  final int? quantity;
  final String? totalUnitPrice;

  @override
  List<Object?> get props => <Object?>[
        name,
        weight,
        totalPrice,
        unitPrice,
        quantity,
        totalUnitPrice,
      ];
}
