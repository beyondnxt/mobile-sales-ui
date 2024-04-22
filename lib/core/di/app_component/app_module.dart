import 'package:injectable/injectable.dart';
import 'package:sales_app/features/companies/data/datasources/local_datasource/local_database.dart';

@module
abstract class AppModule {
  @preResolve
  Future<AppLocalDatabase> get prefs => AppLocalDatabase.create();
}
