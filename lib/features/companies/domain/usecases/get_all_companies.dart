import 'package:injectable/injectable.dart';
import 'package:sales_app/core/commundomain/entitties/based_api_result/api_result_model.dart';
import 'package:sales_app/core/commundomain/usecases/base_params_usecase.dart';
import 'package:sales_app/features/companies/domain/entities/company_response_entity/company_info_entity.dart';
import 'package:sales_app/features/companies/domain/repositories/companies_repository.dart';

@injectable
class GetAllCompanies
    implements BaseParamsUseCase<List<CompanyInfoEntity?>?, NoParams> {
  GetAllCompanies(this.companiesRepository);

  final CompaniesRepository companiesRepository;

  @override
  Future<ApiResultModel<List<CompanyInfoEntity?>?>> call(NoParams? params) {
    return companiesRepository.getAllLocalCompaniesList();
  }
}
