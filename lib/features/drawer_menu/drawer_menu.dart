import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sales_app/core/basecomponents/base_responsive_widget.dart';
import 'package:sales_app/core/utils/helpers/app_configurations_helper/app_configurations_helper.dart';
import 'package:sales_app/core/utils/helpers/extension_functions/size_extension.dart';
import 'package:sales_app/core/utils/helpers/responsive_ui_helper/responsive_config.dart';
import 'package:sales_app/core/utils/values/styles.dart';
import 'package:sales_app/core/widgets/profile_avatar.dart';
import 'package:sales_app/features/attendance/presentation/productList/view/attendance.dart';
import 'package:sales_app/features/companies/presentation/companyList/view/company_list_view.dart';
import 'package:sales_app/features/expense/presentation/expense_list/view/expense_list_view.dart';
import 'package:sales_app/features/products/presentation/productList/view/product_list_view.dart';

class ExampleDestination {
  const ExampleDestination(this.label, this.icon, this.selectedIcon);

  final String label;
  final Widget icon;
  final Widget selectedIcon;
}

const List<ExampleDestination> destinations = <ExampleDestination>[
  ExampleDestination('Companies', Icon(Icons.location_city_outlined),
      Icon(Icons.location_city)),
  ExampleDestination(
      'Leads', Icon(Icons.leaderboard_outlined), Icon(Icons.leaderboard)),
  ExampleDestination('Products', Icon(Icons.shopping_cart_outlined),
      Icon(Icons.shopping_cart)),
  ExampleDestination(
      'Expense', Icon(Icons.attach_money_outlined), Icon(Icons.attach_money)),
  ExampleDestination('Attendance', Icon(Icons.assignment_ind_outlined),
      Icon(Icons.assignment_ind)),
];

@RoutePage()
class DrawerMenu extends StatefulWidget {
  const DrawerMenu({super.key});

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int screenIndex = 0;

  void handleScreenChanged(int selectedScreen) {
    setState(() {
      screenIndex = selectedScreen;
    });
    closeDrawer();
  }

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState!.closeDrawer();
  }

  final List<Widget> screenList = [
    const CompanyListView(),
    const CompanyListView(
      isLead: true,
    ),
    const ProductListView(),
    const ExpenseListView(),
    const AttendanceView(),
  ];

  @override
  Widget build(BuildContext context) {
    return BaseResponsiveWidget(
      initializeConfig: true,
      buildWidget: (BuildContext context, ResponsiveUiConfig responsiveUiConfig,
              AppConfigurations appConfigurations) =>
          Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: appConfigurations.appTheme.primaryColor,
          title: Text(
            destinations[screenIndex].label,
            style: TextStyle(
                color: appConfigurations.appTheme.backgroundLightColor),
          ),
          leading: InkWell(
            onTap: openDrawer,
            child: Icon(
              Icons.menu,
              color: appConfigurations.appTheme.backgroundLightColor,
            ),
          ),
        ),
        body:
            SafeArea(bottom: false, top: false, child: screenList[screenIndex]),
        drawer: NavigationDrawer(
          backgroundColor: Colors.white,
          indicatorColor: appConfigurations.appTheme.backgroundGreyColor,
          onDestinationSelected: handleScreenChanged,
          selectedIndex: screenIndex,
          tilePadding: EdgeInsets.symmetric(
            horizontal: 10.w,
          ),
          children: <Widget>[
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: ProfileAvatarWithName(
                  name: 'Praveen',
                  mailId: 'praveen@mail.com',
                  spaceBetween: 20.h,
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            ...destinations.map(
              (ExampleDestination destination) {
                return NavigationDrawerDestination(
                  label: Text(
                    destination.label,
                    style: poppinsRegular.copyWith(
                      fontSize: 14.w,
                      color: appConfigurations.appTheme.primaryColor,
                    ),
                  ),
                  icon: destination.icon,
                  selectedIcon: destination.selectedIcon,
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
              child: Divider(),
            ),
          ],
        ),
      ),
    );
  }
}
