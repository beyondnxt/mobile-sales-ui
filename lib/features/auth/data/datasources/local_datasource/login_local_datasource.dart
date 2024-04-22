import 'package:sales_app/features/auth/domain/entities/login_entity/login_entity.dart';

abstract class AuthDataSource {
  Future<LoginSuccessEntity?>? login();
}
