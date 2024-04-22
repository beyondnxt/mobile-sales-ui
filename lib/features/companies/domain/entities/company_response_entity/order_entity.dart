import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  const OrderEntity({
    this.statusOfProcessing,
    this.createdBy,
    this.orderNumber,
    this.orderCreatedDate,
  });
  final String? statusOfProcessing;
  final int? orderNumber;
  final String? createdBy;
  final String? orderCreatedDate;

  @override
  List<Object?> get props => <Object?>[
        statusOfProcessing,
        orderNumber,
        createdBy,
        orderCreatedDate,
      ];
}
