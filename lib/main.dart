import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/core/di/app_component/app_component.dart';
import 'package:sales_app/core/utils/auto_router_setup/auto_router.dart';
import 'package:sales_app/core/utils/helpers/app_flavor_helper/app_flavors_helper.dart';
import 'package:sales_app/core/utils/helpers/app_flavor_helper/environment_config.dart';
import 'package:sales_app/features/attendance/presentation/productList/attendance_view_model.dart';
import 'package:sales_app/features/companies/presentation/company/company_details_viewmodel.dart';
import 'package:sales_app/features/companies/presentation/companyList/company_details_viewmodel.dart';
import 'package:sales_app/features/companies/presentation/company_order_details/company_order_details_viewmodel.dart';
import 'package:sales_app/features/expense/presentation/expense_list/expense_list_viewmodel.dart';
import 'package:sales_app/features/products/presentation/productList/product_list_viewmodel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppComponentLocator();
  final AppBaseFlavorsHelper configService = locator<AppBaseFlavorsHelper>();
  final ProductFlavor? productFlavor =
      EnvironmentConfig.BUILD_VARIANT.toProductFlavor();
  configService.configure(productFlavor: productFlavor);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouter _appRouter = AppRouter();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<CompanyDetailsViewModel>(
          create: (BuildContext context) => locator<CompanyDetailsViewModel>(),
        ),
        ChangeNotifierProvider<CompanyListViewModel>(
          create: (BuildContext context) => locator<CompanyListViewModel>(),
        ),
        ChangeNotifierProvider<CompanyOrderViewModel>(
          create: (BuildContext context) => locator<CompanyOrderViewModel>(),
        ),
        ChangeNotifierProvider<ProductListViewModel>(
          create: (BuildContext context) => locator<ProductListViewModel>(),
        ),
        ChangeNotifierProvider<ExpenseListViewModel>(
          create: (BuildContext context) => locator<ExpenseListViewModel>(),
        ),
        ChangeNotifierProvider<AttendanceViewModel>(
          create: (BuildContext context) => locator<AttendanceViewModel>(),
        ),
      ],
      child: MaterialApp.router(
        theme: ThemeData(),
        routerConfig: _appRouter.config(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
