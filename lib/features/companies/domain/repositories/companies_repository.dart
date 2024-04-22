import 'package:sales_app/core/commundomain/entitties/based_api_result/api_result_model.dart';
import 'package:sales_app/features/companies/domain/entities/company_response_entity/company_info_entity.dart';
import 'package:sales_app/features/companies/domain/entities/company_response_entity/feedback_entity.dart';
import 'package:sales_app/features/companies/domain/entities/company_response_entity/order_entity.dart';
import 'package:sales_app/features/products/domain/entities/product_response_entity/product_entity.dart';

abstract class CompaniesRepository {
  Future<ApiResultModel<List<CompanyInfoEntity?>?>> getAllLocalCompaniesList();
  Future<ApiResultModel<bool>> addOrder(OrderEntity data);
  Future<ApiResultModel<List<OrderEntity>?>> getOrders();
  Future<ApiResultModel<bool>> addFeedback(FeedbackEntity data);
  Future<ApiResultModel<List<FeedbackEntity>?>> getFeedbacks();
  Future<ApiResultModel<bool>> addProduct(ProductEntity data);
  Future<ApiResultModel<List<ProductEntity>?>> getProducts();
}
