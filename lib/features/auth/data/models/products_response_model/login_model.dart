import 'package:json_annotation/json_annotation.dart';
import 'package:sales_app/core/utils/mapper/data_mapper.dart';
import 'package:sales_app/features/auth/domain/entities/login_entity/login_entity.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginSuccess extends DataMapper<LoginSuccessEntity> {
  final String message;
final bool status;
  LoginSuccess({
    required this.message,
    required this.status,
  });

  factory LoginSuccess.fromJson(Map<String, dynamic> json) =>
      _$LoginSuccessFromJson(json);

  Map<String, dynamic> toJson() => _$LoginSuccessToJson(this);
  @override
  LoginSuccessEntity mapToEntity() {
    return LoginSuccessEntity(
      message: message,
      status: status,
    
    );
  }
}
