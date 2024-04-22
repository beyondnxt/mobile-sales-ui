import 'package:injectable/injectable.dart';
import 'package:sales_app/core/commundomain/entitties/based_api_result/api_result_model.dart';
import 'package:sales_app/features/companies/data/datasources/local_datasource/companies_local_datasource.dart';
import 'package:sales_app/features/companies/domain/entities/company_response_entity/company_info_entity.dart';
import 'package:sales_app/features/companies/domain/entities/company_response_entity/feedback_entity.dart';
import 'package:sales_app/features/companies/domain/entities/company_response_entity/order_entity.dart';
import 'package:sales_app/features/companies/domain/repositories/companies_repository.dart';
import 'package:sales_app/features/products/domain/entities/product_response_entity/product_entity.dart';

@Injectable(as: CompaniesRepository)
class CompaniesRepositoryImpl implements CompaniesRepository {
  CompaniesRepositoryImpl({
    required this.localDataSource,
  });

  final CompaniesDataSource localDataSource;

  @override
  Future<ApiResultModel<List<CompanyInfoEntity?>?>>
      getAllLocalCompaniesList() async {
    final List<CompanyInfoEntity?>? result =
        await localDataSource.getAllLocalCompanies();
    return ApiResultModel<List<CompanyInfoEntity?>?>.success(
      data: result,
    );
  }

  @override
  Future<ApiResultModel<bool>> addOrder(OrderEntity data) async {
    final bool result = await localDataSource.addOrder(data);
    return ApiResultModel<bool>.success(
      data: result,
    );
  }

  @override
  Future<ApiResultModel<List<OrderEntity>?>> getOrders() async {
    final List<OrderEntity> result = await localDataSource.getOrders();
    return ApiResultModel<List<OrderEntity>?>.success(
      data: result,
    );
  }

  @override
  Future<ApiResultModel<bool>> addFeedback(FeedbackEntity data) async{
    final bool result = await localDataSource.addFeedback(data);
    return ApiResultModel<bool>.success(
      data: result,
    );
  }

  @override
  Future<ApiResultModel<List<FeedbackEntity>?>> getFeedbacks()async {
   final List<FeedbackEntity> result = await localDataSource.getFeedbacks();
    return ApiResultModel<List<FeedbackEntity>?>.success(
      data: result,
    );
  }

  @override
  Future<ApiResultModel<bool>> addProduct(ProductEntity data) async{
   final bool result = await localDataSource.addProducts(data);
    return ApiResultModel<bool>.success(
      data: result,
    );
  }

  @override
  Future<ApiResultModel<List<ProductEntity>?>> getProducts() async{
   final List<ProductEntity> result = await localDataSource.getProducts();
    return ApiResultModel<List<ProductEntity>?>.success(
      data: result,
    );
  }
}
