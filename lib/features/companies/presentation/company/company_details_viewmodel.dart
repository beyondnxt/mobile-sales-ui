import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:sales_app/core/basecomponents/base_view_model.dart';
import 'package:sales_app/core/commundomain/entitties/based_api_result/api_result_state.dart';
import 'package:sales_app/features/companies/domain/entities/company_response_entity/feedback_entity.dart';
import 'package:sales_app/features/companies/domain/entities/company_response_entity/order_entity.dart';
import 'package:sales_app/features/companies/domain/usecases/get_all_feedbacks.dart';
import 'package:sales_app/features/companies/domain/usecases/get_all_orders.dart';

@injectable
class CompanyDetailsViewModel extends BaseViewModel {
  CompanyDetailsViewModel(this.getAllOrders, this.getAllFeedbacks);

  final GetAllOrders getAllOrders;
  final GetAllFeedbacks getAllFeedbacks;
  final StreamController<ApiResultState<OrderEntity?>?> _orderResult =
      StreamController<ApiResultState<OrderEntity?>?>.broadcast();

  StreamController<ApiResultState<OrderEntity?>?> get orderResult =>
      _orderResult;
  final StreamController<ApiResultState<List<OrderEntity?>?>?>
      _orderListResult =
      StreamController<ApiResultState<List<OrderEntity?>?>?>.broadcast();
  StreamController<ApiResultState<List<OrderEntity?>?>?> get orderListResult =>
      _orderListResult;

  final StreamController<ApiResultState<FeedbackEntity?>?> _feedbackResult =
      StreamController<ApiResultState<FeedbackEntity?>?>.broadcast();

  StreamController<ApiResultState<FeedbackEntity?>?> get feedbackResult =>
      _feedbackResult;
  final StreamController<ApiResultState<List<FeedbackEntity?>?>?>
      _feedbackListResult =
      StreamController<ApiResultState<List<FeedbackEntity?>?>?>.broadcast();
  StreamController<ApiResultState<List<FeedbackEntity?>?>?>
      get feedbackListResult => _feedbackListResult;

  Future<void> getAllOrdersData() async {
    final ApiResultState<List<OrderEntity?>?>? result =
        await executeParamsUseCase(
      useCase: getAllOrders,
    );
    _orderListResult.add(result);
  }

  Future<void> getAllFeedbackData() async {
    final ApiResultState<List<FeedbackEntity?>?>? result =
        await executeParamsUseCase(
      useCase: getAllFeedbacks,
    );
    _feedbackListResult.add(result);
  }

  @override
  void onDispose() {
    super.onDispose();
    _orderListResult.close();
    _orderResult.close();
  }
}
