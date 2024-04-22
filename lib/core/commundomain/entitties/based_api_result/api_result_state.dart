import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sales_app/core/commundomain/entitties/based_api_result/error_result_model.dart';

part 'api_result_state.freezed.dart';

@freezed
class ApiResultState<T> with _$ApiResultState<T> {
  const factory ApiResultState.data({required T data}) = Data<T>;

  const factory ApiResultState.error(
      {required ErrorResultModel errorResultModel}) = Error<T>;
}
