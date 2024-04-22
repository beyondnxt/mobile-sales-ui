import 'package:equatable/equatable.dart';

class LeaveEntity extends Equatable {
  const LeaveEntity({this.date, this.type});
  final String? date;
  final String? type;

  @override
  List<Object?> get props => <Object?>[
        type,
        date,
      ];
}
