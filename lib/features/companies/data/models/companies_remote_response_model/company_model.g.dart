// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Company _$CompanyFromJson(Map<String, dynamic> json) => Company(
      companyName: json['company_name'] as String,
      address: json['address'] as String,
      phoneNumber: json['phone_number'] as int,
    );

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
      'company_name': instance.companyName,
      'address': instance.address,
      'phone_number': instance.phoneNumber,
    };