import 'package:sales_app/core/utils/mapper/data_mapper.dart';
import 'package:sales_app/features/companies/domain/entities/company_response_entity/order_entity.dart';

class OrderDataMapperToEntity extends DataMapper<OrderEntity> {
  OrderDataMapperToEntity({
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
  OrderEntity mapToEntity() {
    return OrderEntity(
      statusOfProcessing: statusOfProcessing,
      orderNumber: orderNumber,
      createdBy: createdBy,
      orderCreatedDate: orderCreatedDate,
    );
  }
}
