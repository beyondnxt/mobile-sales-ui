import 'package:sales_app/core/utils/mapper/data_mapper.dart';
import 'package:sales_app/features/companies/domain/entities/company_response_entity/company_info_entity.dart';

class CompanyDataMapperToEntity extends DataMapper<CompanyInfoEntity> {
  CompanyDataMapperToEntity({
    this.name,
    this.phoneNumber,
    this.address,
  });

  String? name;
  String? address;
  int? phoneNumber;

  @override
  CompanyInfoEntity mapToEntity() {
    return CompanyInfoEntity(
      address: address,
      phoneNumber: phoneNumber,
      name: name,
    );
  }
}
