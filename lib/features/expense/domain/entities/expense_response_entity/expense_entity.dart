import 'package:equatable/equatable.dart';

class ExpenseEntity extends Equatable {
  const ExpenseEntity({this.expense, this.date});
  final String? expense;
  final String? date;

  @override
  List<Object?> get props => <Object?>[
        expense,
        date,
      ];
}
