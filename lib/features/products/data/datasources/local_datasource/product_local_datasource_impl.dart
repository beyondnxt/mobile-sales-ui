import 'package:injectable/injectable.dart';
import 'package:sales_app/features/companies/data/datasources/local_datasource/local_database.dart';
import 'package:sales_app/features/products/data/datasources/local_datasource/products_local_datasource.dart';
import 'package:sales_app/features/products/domain/entities/product_response_entity/product_entity.dart';

@Injectable(as: ProductDataSource)
class ProductDataSourceImpl implements ProductDataSource {
  ProductDataSourceImpl(this.appLocalDatabase);

  final AppLocalDatabase appLocalDatabase;

  @override
  Future<List<ProductEntity>?> getAllProducts() async {
    final List<ProductEntity> data = appLocalDatabase.getProducts();

    return data;
  }
}
