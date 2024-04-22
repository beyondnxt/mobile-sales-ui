import 'package:auto_route/auto_route.dart';
import 'package:sales_app/core/utils/auto_router_setup/auto_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[
        AutoRoute(
          page: CompanyListView.page,
        ),
        AutoRoute(
          page: CompanyDetailsView.page,
        ),
        AutoRoute(
          page: ProductListView.page,
        ),
        AutoRoute(
          page: OrderDetailsView.page,
        ),
        AutoRoute(
          page: AttendanceView.page,
        ),
        AutoRoute(
          page: RequestLeaveView.page,
        ),
        AutoRoute(page: DrawerMenu.page),
        AutoRoute(initial: true, page: SignInRoute.page),
        AutoRoute(page: ForgotPassRoute.page),
      ];
}
