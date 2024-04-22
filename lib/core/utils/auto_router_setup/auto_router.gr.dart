// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:flutter/material.dart' as _i12;
import 'package:sales_app/features/attendance/presentation/productList/view/attendance.dart'
    as _i1;
import 'package:sales_app/features/attendance/presentation/productList/view/request_leave.dart'
    as _i9;
import 'package:sales_app/features/auth/presentation/productList/view/forgot_password_screen.dart'
    as _i6;
import 'package:sales_app/features/auth/presentation/productList/view/login_screen.dart'
    as _i10;
import 'package:sales_app/features/companies/domain/entities/company_response_entity/company_info_entity.dart'
    as _i13;
import 'package:sales_app/features/companies/domain/entities/company_response_entity/order_entity.dart'
    as _i14;
import 'package:sales_app/features/companies/presentation/company/view/company_details_view.dart'
    as _i2;
import 'package:sales_app/features/companies/presentation/company_order_details/view/order_details_view.dart'
    as _i7;
import 'package:sales_app/features/companies/presentation/companyList/view/company_list_view.dart'
    as _i3;
import 'package:sales_app/features/drawer_menu/drawer_menu.dart' as _i4;
import 'package:sales_app/features/expense/presentation/expense_list/view/expense_list_view.dart'
    as _i5;
import 'package:sales_app/features/products/presentation/productList/view/product_list_view.dart'
    as _i8;

abstract class $AppRouter extends _i11.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i11.PageFactory> pagesMap = {
    AttendanceView.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AttendanceView(),
      );
    },
    CompanyDetailsView.name: (routeData) {
      final args = routeData.argsAs<CompanyDetailsViewArgs>(
          orElse: () => const CompanyDetailsViewArgs());
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.CompanyDetailsView(
          key: args.key,
          companyInfoEntity: args.companyInfoEntity,
        ),
      );
    },
    CompanyListView.name: (routeData) {
      final args = routeData.argsAs<CompanyListViewArgs>(
          orElse: () => const CompanyListViewArgs());
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.CompanyListView(
          key: args.key,
          isLead: args.isLead,
        ),
      );
    },
    DrawerMenu.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.DrawerMenu(),
      );
    },
    ExpenseListView.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.ExpenseListView(),
      );
    },
    ForgotPassRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.ForgotPassPage(),
      );
    },
    OrderDetailsView.name: (routeData) {
      final args = routeData.argsAs<OrderDetailsViewArgs>(
          orElse: () => const OrderDetailsViewArgs());
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.OrderDetailsView(
          key: args.key,
          orderEntity: args.orderEntity,
        ),
      );
    },
    ProductListView.name: (routeData) {
      final args = routeData.argsAs<ProductListViewArgs>(
          orElse: () => const ProductListViewArgs());
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.ProductListView(
          key: args.key,
          fromOrder: args.fromOrder,
        ),
      );
    },
    RequestLeaveView.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.RequestLeaveView(),
      );
    },
    SignInRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.SignInPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.AttendanceView]
class AttendanceView extends _i11.PageRouteInfo<void> {
  const AttendanceView({List<_i11.PageRouteInfo>? children})
      : super(
          AttendanceView.name,
          initialChildren: children,
        );

  static const String name = 'AttendanceView';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i2.CompanyDetailsView]
class CompanyDetailsView extends _i11.PageRouteInfo<CompanyDetailsViewArgs> {
  CompanyDetailsView({
    _i12.Key? key,
    _i13.CompanyInfoEntity? companyInfoEntity,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          CompanyDetailsView.name,
          args: CompanyDetailsViewArgs(
            key: key,
            companyInfoEntity: companyInfoEntity,
          ),
          initialChildren: children,
        );

  static const String name = 'CompanyDetailsView';

  static const _i11.PageInfo<CompanyDetailsViewArgs> page =
      _i11.PageInfo<CompanyDetailsViewArgs>(name);
}

class CompanyDetailsViewArgs {
  const CompanyDetailsViewArgs({
    this.key,
    this.companyInfoEntity,
  });

  final _i12.Key? key;

  final _i13.CompanyInfoEntity? companyInfoEntity;

  @override
  String toString() {
    return 'CompanyDetailsViewArgs{key: $key, companyInfoEntity: $companyInfoEntity}';
  }
}

/// generated route for
/// [_i3.CompanyListView]
class CompanyListView extends _i11.PageRouteInfo<CompanyListViewArgs> {
  CompanyListView({
    _i12.Key? key,
    bool isLead = false,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          CompanyListView.name,
          args: CompanyListViewArgs(
            key: key,
            isLead: isLead,
          ),
          initialChildren: children,
        );

  static const String name = 'CompanyListView';

  static const _i11.PageInfo<CompanyListViewArgs> page =
      _i11.PageInfo<CompanyListViewArgs>(name);
}

class CompanyListViewArgs {
  const CompanyListViewArgs({
    this.key,
    this.isLead = false,
  });

  final _i12.Key? key;

  final bool isLead;

  @override
  String toString() {
    return 'CompanyListViewArgs{key: $key, isLead: $isLead}';
  }
}

/// generated route for
/// [_i4.DrawerMenu]
class DrawerMenu extends _i11.PageRouteInfo<void> {
  const DrawerMenu({List<_i11.PageRouteInfo>? children})
      : super(
          DrawerMenu.name,
          initialChildren: children,
        );

  static const String name = 'DrawerMenu';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i5.ExpenseListView]
class ExpenseListView extends _i11.PageRouteInfo<void> {
  const ExpenseListView({List<_i11.PageRouteInfo>? children})
      : super(
          ExpenseListView.name,
          initialChildren: children,
        );

  static const String name = 'ExpenseListView';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i6.ForgotPassPage]
class ForgotPassRoute extends _i11.PageRouteInfo<void> {
  const ForgotPassRoute({List<_i11.PageRouteInfo>? children})
      : super(
          ForgotPassRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgotPassRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i7.OrderDetailsView]
class OrderDetailsView extends _i11.PageRouteInfo<OrderDetailsViewArgs> {
  OrderDetailsView({
    _i12.Key? key,
    _i14.OrderEntity? orderEntity,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          OrderDetailsView.name,
          args: OrderDetailsViewArgs(
            key: key,
            orderEntity: orderEntity,
          ),
          initialChildren: children,
        );

  static const String name = 'OrderDetailsView';

  static const _i11.PageInfo<OrderDetailsViewArgs> page =
      _i11.PageInfo<OrderDetailsViewArgs>(name);
}

class OrderDetailsViewArgs {
  const OrderDetailsViewArgs({
    this.key,
    this.orderEntity,
  });

  final _i12.Key? key;

  final _i14.OrderEntity? orderEntity;

  @override
  String toString() {
    return 'OrderDetailsViewArgs{key: $key, orderEntity: $orderEntity}';
  }
}

/// generated route for
/// [_i8.ProductListView]
class ProductListView extends _i11.PageRouteInfo<ProductListViewArgs> {
  ProductListView({
    _i12.Key? key,
    bool fromOrder = false,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          ProductListView.name,
          args: ProductListViewArgs(
            key: key,
            fromOrder: fromOrder,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductListView';

  static const _i11.PageInfo<ProductListViewArgs> page =
      _i11.PageInfo<ProductListViewArgs>(name);
}

class ProductListViewArgs {
  const ProductListViewArgs({
    this.key,
    this.fromOrder = false,
  });

  final _i12.Key? key;

  final bool fromOrder;

  @override
  String toString() {
    return 'ProductListViewArgs{key: $key, fromOrder: $fromOrder}';
  }
}

/// generated route for
/// [_i9.RequestLeaveView]
class RequestLeaveView extends _i11.PageRouteInfo<void> {
  const RequestLeaveView({List<_i11.PageRouteInfo>? children})
      : super(
          RequestLeaveView.name,
          initialChildren: children,
        );

  static const String name = 'RequestLeaveView';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i10.SignInPage]
class SignInRoute extends _i11.PageRouteInfo<void> {
  const SignInRoute({List<_i11.PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}
