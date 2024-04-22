import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:sales_app/core/basecomponents/base_view_model.dart';
import 'package:sales_app/core/commundomain/entitties/based_api_result/api_result_state.dart';
import 'package:sales_app/features/companies/domain/entities/company_response_entity/company_info_entity.dart';
import 'package:sales_app/features/companies/domain/usecases/get_all_companies.dart';

@injectable
class CompanyListViewModel extends BaseViewModel {
  CompanyListViewModel(
    this.getAllLocalCompany,
  );

  final GetAllCompanies getAllLocalCompany;

  final StreamController<ApiResultState<List<CompanyInfoEntity?>?>?>
      _companyResult =
      StreamController<ApiResultState<List<CompanyInfoEntity?>?>?>.broadcast();

  StreamController<ApiResultState<List<CompanyInfoEntity?>?>?>
      get companyResult => _companyResult;

  Future<void> getAllLocalCompanies() async {
    final ApiResultState<List<CompanyInfoEntity?>?>? result =
        await executeParamsUseCase(
      useCase: getAllLocalCompany,
    );
    _companyResult.add(result);
  }

  @override
  void onDispose() {
    super.onDispose();
    _companyResult.close();
  }
}
