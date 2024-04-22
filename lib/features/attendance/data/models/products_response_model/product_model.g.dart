// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      name: json['name'] as String,
      weight: json['weight'] as String,
      totalPrice: json['totalPrice'] as String,
      unitPrice: json['unitPrice'] as String,
      quantity: json['quantity'] as int,
      totalUnitPrice: json['totalUnitPrice'] as String,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'name': instance.name,
      'weight': instance.weight,
      'totalPrice': instance.totalPrice,
      'unitPrice': instance.unitPrice,
      'quantity': instance.quantity,
      'totalUnitPrice': instance.totalUnitPrice,
    };
