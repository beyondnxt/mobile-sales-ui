import 'package:injectable/injectable.dart';
import 'package:sales_app/core/commundomain/entitties/based_api_result/api_result_model.dart';
import 'package:sales_app/core/commundomain/usecases/base_params_usecase.dart';
import 'package:sales_app/features/products/domain/entities/product_response_entity/product_entity.dart';
import 'package:sales_app/features/products/domain/repositories/product_repository.dart';

@injectable
class GetAllProducts
    implements BaseParamsUseCase<List<ProductEntity?>?, NoParams> {
  GetAllProducts(this.productRepository);

  final ProductRepository productRepository;

  @override
  Future<ApiResultModel<List<ProductEntity?>?>> call(NoParams? params) {
    return productRepository.getAllProductsList();
  }
}
