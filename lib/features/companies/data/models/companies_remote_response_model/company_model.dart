import 'package:json_annotation/json_annotation.dart';
import 'package:sales_app/core/utils/mapper/data_mapper.dart';
import 'package:sales_app/features/companies/domain/entities/company_reponse_mapper_to_entity/company_entity_mapper.dart';

part 'company_model.g.dart';

@JsonSerializable()
class Company extends DataMapper<CompanyDataMapperToEntity> {
  @JsonKey(name: 'company_name')
  final String companyName;

  final String address;

  @JsonKey(name: 'phone_number')
  final int phoneNumber;

  Company({
    required this.companyName,
    required this.address,
    required this.phoneNumber,
  });

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyToJson(this);

  @override
  CompanyDataMapperToEntity mapToEntity() {
    return CompanyDataMapperToEntity(
        address: address, name: companyName, phoneNumber: phoneNumber);
  }
}
