// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:sales_app/core/di/app_component/app_module.dart' as _i44;
import 'package:sales_app/core/utils/helpers/app_configurations_helper/app_configurations_helper.dart'
    as _i5;
import 'package:sales_app/core/utils/helpers/app_flavor_helper/app_flavors_helper.dart'
    as _i6;
import 'package:sales_app/core/utils/helpers/connectivity_helper/connectivity_checker_helper.dart'
    as _i4;
import 'package:sales_app/core/utils/helpers/http_strategy_helper/http_request_context.dart'
    as _i27;
import 'package:sales_app/core/utils/helpers/responsive_ui_helper/responsive_config.dart'
    as _i7;
import 'package:sales_app/features/attendance/data/datasources/local_datasource/product_local_datasource_impl.dart'
    as _i11;
import 'package:sales_app/features/attendance/data/datasources/local_datasource/products_local_datasource.dart'
    as _i10;
import 'package:sales_app/features/attendance/data/repositories/products_repository_impl.dart'
    as _i26;
import 'package:sales_app/features/attendance/domain/repositories/product_repository.dart'
    as _i25;
import 'package:sales_app/features/attendance/domain/usecases/get_all_products.dart'
    as _i28;
import 'package:sales_app/features/attendance/presentation/productList/attendance_view_model.dart'
    as _i40;
import 'package:sales_app/features/auth/data/datasources/local_datasource/login_local_datasource_impl.dart'
    as _i13;
import 'package:sales_app/features/auth/data/datasources/local_datasource/login_local_datasource.dart'
    as _i12;
import 'package:sales_app/features/auth/data/repositories/products_repository_impl.dart'
    as _i32;
import 'package:sales_app/features/auth/domain/repositories/auth_repository.dart'
    as _i31;
import 'package:sales_app/features/auth/domain/usecases/login.dart' as _i37;
import 'package:sales_app/features/auth/presentation/productList/attendance_view_model.dart'
    as _i41;
import 'package:sales_app/features/companies/data/datasources/local_datasource/companies_local_datasource.dart'
    as _i16;
import 'package:sales_app/features/companies/data/datasources/local_datasource/companies_local_datasource_impl.dart'
    as _i17;
import 'package:sales_app/features/companies/data/datasources/local_datasource/local_database.dart'
    as _i3;
import 'package:sales_app/features/companies/data/repositories/companies_repository_impl.dart'
    as _i24;
import 'package:sales_app/features/companies/domain/repositories/companies_repository.dart'
    as _i23;
import 'package:sales_app/features/companies/domain/usecases/get_all_companies.dart'
    as _i33;
import 'package:sales_app/features/companies/domain/usecases/get_all_feedbacks.dart'
    as _i34;
import 'package:sales_app/features/companies/domain/usecases/get_all_orders.dart'
    as _i35;
import 'package:sales_app/features/companies/domain/usecases/get_all_products.dart'
    as _i36;
import 'package:sales_app/features/companies/presentation/company/company_details_viewmodel.dart'
    as _i38;
import 'package:sales_app/features/companies/presentation/company_order_details/company_order_details_viewmodel.dart'
    as _i42;
import 'package:sales_app/features/companies/presentation/companyList/company_details_viewmodel.dart'
    as _i39;
import 'package:sales_app/features/expense/data/datasources/local_datasource/expense_local_datasource.dart'
    as _i8;
import 'package:sales_app/features/expense/data/datasources/local_datasource/expense_local_datasource_impl.dart'
    as _i9;
import 'package:sales_app/features/expense/data/repositories/products_repository_impl.dart'
    as _i19;
import 'package:sales_app/features/expense/domain/repositories/expense_repository.dart'
    as _i18;
import 'package:sales_app/features/expense/domain/usecases/get_all_expense.dart'
    as _i20;
import 'package:sales_app/features/expense/presentation/expense_list/expense_list_viewmodel.dart'
    as _i30;
import 'package:sales_app/features/products/data/datasources/local_datasource/product_local_datasource_impl.dart'
    as _i15;
import 'package:sales_app/features/products/data/datasources/local_datasource/products_local_datasource.dart'
    as _i14;
import 'package:sales_app/features/products/data/repositories/products_repository_impl.dart'
    as _i22;
import 'package:sales_app/features/products/domain/repositories/product_repository.dart'
    as _i21;
import 'package:sales_app/features/products/domain/usecases/get_all_products.dart'
    as _i29;
import 'package:sales_app/features/products/presentation/productList/product_list_viewmodel.dart'
    as _i43;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    await gh.factoryAsync<_i3.AppLocalDatabase>(
      () => appModule.prefs,
      preResolve: true,
    );
    gh.factory<_i4.ConnectivityCheckerHelper>(
        () => _i4.ConnectivityCheckerHelper());
    gh.singleton<_i5.AppConfigurations>(() => _i5.AppConfigurations());
    gh.singleton<_i6.AppBaseFlavorsHelper>(() => _i6.AppBaseFlavorsHelper());
    gh.singleton<_i7.ResponsiveUiConfig>(() => _i7.ResponsiveUiConfig());
    gh.factory<_i8.ExpenseDataSource>(
        () => _i9.ExpenseDataSourceImpl(gh<_i3.AppLocalDatabase>()));
    gh.factory<_i10.AttendanceDataSource>(
        () => _i11.AttendanceDataSourceImpl(gh<_i3.AppLocalDatabase>()));
    gh.factory<_i12.AuthDataSource>(
        () => _i13.LoginDataSourceImpl(gh<_i3.AppLocalDatabase>()));
    gh.factory<_i14.ProductDataSource>(
        () => _i15.ProductDataSourceImpl(gh<_i3.AppLocalDatabase>()));
    gh.factory<_i16.CompaniesDataSource>(
        () => _i17.CompaniesDataSourceImpl(gh<_i3.AppLocalDatabase>()));
    gh.factory<_i18.ExpenseRepository>(() => _i19.ExpenseRepositoryImpl(
        localDataSource: gh<_i8.ExpenseDataSource>()));
    gh.factory<_i20.GetAllExpense>(
        () => _i20.GetAllExpense(gh<_i18.ExpenseRepository>()));
    gh.factory<_i21.ProductRepository>(() => _i22.ProductsRepositoryImpl(
        localDataSource: gh<_i14.ProductDataSource>()));
    gh.factory<_i23.CompaniesRepository>(() => _i24.CompaniesRepositoryImpl(
        localDataSource: gh<_i16.CompaniesDataSource>()));
    gh.factory<_i25.AttendanceRepository>(() => _i26.AttendanceRepositoryImpl(
        localDataSource: gh<_i14.ProductDataSource>()));
    gh.factory<_i27.HttpRequestContext>(
        () => _i27.HttpRequestContext(gh<_i4.ConnectivityCheckerHelper>()));
    gh.factory<_i28.GetAllProducts>(
        () => _i28.GetAllProducts(gh<_i21.ProductRepository>()));
    gh.factory<_i29.GetAllProducts>(
        () => _i29.GetAllProducts(gh<_i21.ProductRepository>()));
    gh.factory<_i30.ExpenseListViewModel>(
        () => _i30.ExpenseListViewModel(gh<_i20.GetAllExpense>()));
    gh.factory<_i31.LoginRespository>(() =>
        _i32.LoginRepositoryImpl(localDataSource: gh<_i12.AuthDataSource>()));
    gh.factory<_i33.GetAllCompanies>(
        () => _i33.GetAllCompanies(gh<_i23.CompaniesRepository>()));
    gh.factory<_i34.GetAllFeedbacks>(
        () => _i34.GetAllFeedbacks(gh<_i23.CompaniesRepository>()));
    gh.factory<_i35.GetAllOrders>(
        () => _i35.GetAllOrders(gh<_i23.CompaniesRepository>()));
    gh.factory<_i36.GetAllProductsForOrder>(
        () => _i36.GetAllProductsForOrder(gh<_i23.CompaniesRepository>()));
    gh.factory<_i37.Auth>(() => _i37.Auth(gh<_i31.LoginRespository>()));
    gh.factory<_i38.CompanyDetailsViewModel>(() => _i38.CompanyDetailsViewModel(
          gh<_i35.GetAllOrders>(),
          gh<_i34.GetAllFeedbacks>(),
        ));
    gh.factory<_i39.CompanyListViewModel>(
        () => _i39.CompanyListViewModel(gh<_i33.GetAllCompanies>()));
    gh.factory<_i40.AttendanceViewModel>(
        () => _i40.AttendanceViewModel(gh<_i36.GetAllProductsForOrder>()));
    gh.factory<_i41.AttendanceViewModel>(
        () => _i41.AttendanceViewModel(gh<_i36.GetAllProductsForOrder>()));
    gh.factory<_i42.CompanyOrderViewModel>(
        () => _i42.CompanyOrderViewModel(gh<_i36.GetAllProductsForOrder>()));
    gh.factory<_i43.ProductListViewModel>(
        () => _i43.ProductListViewModel(gh<_i36.GetAllProductsForOrder>()));
    return this;
  }
}

class _$AppModule extends _i44.AppModule {}
