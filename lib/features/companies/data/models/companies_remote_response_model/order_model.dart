import 'package:json_annotation/json_annotation.dart';
import 'package:sales_app/core/utils/mapper/data_mapper.dart';
import 'package:sales_app/features/companies/domain/entities/company_reponse_mapper_to_entity/order_entity_mapper.dart';

part 'order_model.g.dart';

@JsonSerializable()
class Order extends DataMapper<OrderDataMapperToEntity>  {
  @JsonKey(name: 'status_of_processing')
  String statusOfProcessing;

  @JsonKey(name: 'created_by')
  String createdBy;

  @JsonKey(name: 'order_number')
  int orderNumber;

  @JsonKey(name: 'order_created_date')
  String orderCreatedDate;

  Order({
    required this.statusOfProcessing,
    required this.createdBy,
    required this.orderNumber,
    required this.orderCreatedDate,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
  
  @override
  OrderDataMapperToEntity mapToEntity() {
    return OrderDataMapperToEntity(
      statusOfProcessing: statusOfProcessing,
      orderNumber: orderNumber,
      createdBy: createdBy,
      orderCreatedDate: orderCreatedDate,
    );
  }
}