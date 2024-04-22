import 'package:injectable/injectable.dart';
import 'package:sales_app/core/commundomain/entitties/based_api_result/api_result_model.dart';
import 'package:sales_app/features/products/data/datasources/local_datasource/products_local_datasource.dart';
import 'package:sales_app/features/products/domain/entities/product_response_entity/product_entity.dart';
import 'package:sales_app/features/products/domain/repositories/product_repository.dart';

@Injectable(as: ProductRepository)
class ProductsRepositoryImpl implements ProductRepository {
  ProductsRepositoryImpl({
    required this.localDataSource,
  });

  final ProductDataSource localDataSource;

  @override
  Future<ApiResultModel<List<ProductEntity?>?>> getAllProductsList() async {
    final List<ProductEntity>? result = await localDataSource.getAllProducts();
    return ApiResultModel<List<ProductEntity>?>.success(
      data: result,
    );
  }
}
