import 'package:equatable/equatable.dart';

class LoginSuccessEntity extends Equatable {
  const LoginSuccessEntity({this.message, this.status});
  final bool? status;
  final String? message;

  @override
  List<Object?> get props => <Object?>[
        status,
        message,
      ];
}
