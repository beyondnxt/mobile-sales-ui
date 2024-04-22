import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:sales_app/core/basecomponents/base_view_model.dart';
import 'package:sales_app/core/commundomain/entitties/based_api_result/api_result_state.dart';
import 'package:sales_app/features/companies/domain/usecases/get_all_products.dart';
import 'package:sales_app/features/products/domain/entities/product_response_entity/product_entity.dart';

@injectable
class ProductListViewModel extends BaseViewModel {
  ProductListViewModel(
    this.getAllProductForOrders,
  );

   final GetAllProductsForOrder getAllProductForOrders;
  final StreamController<ApiResultState<ProductEntity?>?> _productResult =
      StreamController<ApiResultState<ProductEntity?>?>.broadcast();

  StreamController<ApiResultState<ProductEntity?>?> get productResult =>
      _productResult;
  final StreamController<ApiResultState<List<ProductEntity?>?>?>
      _productListResult =
      StreamController<ApiResultState<List<ProductEntity?>?>?>.broadcast();
  StreamController<ApiResultState<List<ProductEntity?>?>?>
      get productListResult => _productListResult;

  Future<void> getAllProductsData() async {
    final ApiResultState<List<ProductEntity?>?>? result =
        await executeParamsUseCase(
      useCase: getAllProductForOrders,
    );
    _productListResult.add(result);
  }

  @override
  void onDispose() {
    super.onDispose();
    _productListResult.close();
    _productResult.close();
  }
}
