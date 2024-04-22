import 'package:injectable/injectable.dart';
import 'package:sales_app/features/companies/data/datasources/local_datasource/companies_local_datasource.dart';
import 'package:sales_app/features/companies/data/datasources/local_datasource/local_database.dart';
import 'package:sales_app/features/companies/domain/entities/company_reponse_mapper_to_entity/company_entity_mapper.dart';
import 'package:sales_app/features/companies/domain/entities/company_response_entity/company_info_entity.dart';
import 'package:sales_app/features/companies/domain/entities/company_response_entity/feedback_entity.dart';
import 'package:sales_app/features/companies/domain/entities/company_response_entity/order_entity.dart';
import 'package:sales_app/features/products/domain/entities/product_response_entity/product_entity.dart';

@Injectable(as: CompaniesDataSource)
class CompaniesDataSourceImpl implements CompaniesDataSource {
  CompaniesDataSourceImpl(this.appLocalDatabase);

  final AppLocalDatabase appLocalDatabase;

  @override
  Future<List<CompanyInfoEntity?>?> getAllLocalCompanies() async {
    final List<CompanyDataMapperToEntity>? companyInfoData =
        appLocalDatabase.getAll<CompanyDataMapperToEntity>();
    if ((companyInfoData?.length ?? 0) > 0) {
      final List<CompanyInfoEntity?>? localData = companyInfoData
          ?.map((CompanyDataMapperToEntity element) => element.mapToEntity())
          .toList();
      return localData;
    }
    return null;
  }

  @override
  Future<bool> addOrder(OrderEntity data) async {
    final bool companyInfoData = appLocalDatabase.addOrder(data);

    return companyInfoData;
  }

  @override
  Future<List<OrderEntity>> getOrders() async {
    final List<OrderEntity> data = appLocalDatabase.getOrders();

    return data;
  }

  @override
  Future<bool> addFeedback(FeedbackEntity data) async {
    final bool companyInfoData = appLocalDatabase.addFeedback(data);

    return companyInfoData;
  }

  @override
  Future<List<FeedbackEntity>> getFeedbacks() async {
    final List<FeedbackEntity> data = appLocalDatabase.getFeedbacks();

    return data;
  }

  @override
  Future<bool> addProducts(ProductEntity data) async {
    final bool productData = appLocalDatabase.addProducts(data);

    return productData;
  }

  @override
  Future<List<ProductEntity>> getProducts() async {
    final List<ProductEntity> data = appLocalDatabase.getProducts();

    return data;
  }
}
