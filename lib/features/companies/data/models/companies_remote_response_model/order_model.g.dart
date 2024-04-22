// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      statusOfProcessing: json['status_of_processing'] as String,
      createdBy: json['created_by'] as String,
      orderNumber: json['order_number'] as int,
      orderCreatedDate: json['order_created_date'] as String,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'status_of_processing': instance.statusOfProcessing,
      'created_by': instance.createdBy,
      'order_number': instance.orderNumber,
      'order_created_date': instance.orderCreatedDate,
    };
