import 'package:equatable/equatable.dart';

class FeedbackEntity extends Equatable {
  const FeedbackEntity({
    this.statusOfProcessing,
    this.createdBy,
    this.feedBackDescription,
    this.orderCreatedDate,
  });
  final String? statusOfProcessing;
  final String? feedBackDescription;
  final String? createdBy;
  final String? orderCreatedDate;

  @override
  List<Object?> get props => <Object?>[
        statusOfProcessing,
        feedBackDescription,
        createdBy,
        orderCreatedDate,
      ];
}
