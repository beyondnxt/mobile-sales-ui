import 'package:sales_app/features/companies/domain/entities/company_response_entity/company_info_entity.dart';
import 'package:sales_app/features/companies/domain/entities/company_response_entity/feedback_entity.dart';
import 'package:sales_app/features/companies/domain/entities/company_response_entity/order_entity.dart';
import 'package:sales_app/features/products/domain/entities/product_response_entity/product_entity.dart';

abstract class CompaniesDataSource {
  Future<List<CompanyInfoEntity?>?> getAllLocalCompanies();
  Future<bool> addOrder(OrderEntity data);
  Future<List<OrderEntity>> getOrders();
  Future<bool> addFeedback(FeedbackEntity data);
  Future<List<FeedbackEntity>> getFeedbacks();
    Future<bool> addProducts(ProductEntity data);
  Future<List<ProductEntity>> getProducts();
}
