import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sales_app/core/basecomponents/base_responsive_widget.dart';
import 'package:sales_app/core/utils/auto_router_setup/auto_router.gr.dart';
import 'package:sales_app/core/utils/helpers/app_configurations_helper/app_configurations_helper.dart';
import 'package:sales_app/core/utils/helpers/extension_functions/size_extension.dart';
import 'package:sales_app/core/utils/helpers/responsive_ui_helper/responsive_config.dart';
import 'package:sales_app/core/utils/values/styles.dart';
import 'package:sales_app/core/widgets/custom_field.dart';
import 'package:sales_app/core/widgets/custom_text_button.dart';
import 'package:sales_app/features/auth/presentation/productList/view/forgot_password_screen.dart';

@RoutePage()
class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BaseResponsiveWidget(
          initializeConfig: true,
          buildWidget: (BuildContext context,
              ResponsiveUiConfig responsiveUiConfig,
              AppConfigurations appConfigurations) {
        return Scaffold(
          backgroundColor: appConfigurations.appTheme.primaryColor,
          body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),

            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 1,
              ),
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: Image.asset(
                    'assets/img_login.png',
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const CustomField(
                  iconUrl: 'assets/icon_email.png',
                  hint: 'Email',
                ),  const SizedBox(
                  height: 30,
                ),
                const CustomField(
                  iconUrl: 'assets/icon_password.png',
                  hint: 'Password',
                ),const SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgotPassPage()),
                      );
                    },
                    child: Text(
                      "Forget Password?",
                      style: poppinsRegular.copyWith(
                        fontSize: 14.w,
                        fontWeight: FontWeight.bold,
                        color: appConfigurations.appTheme.backgroundLightColor,
                      ),
                    ),
                  ),
                ),
                CustomTextButton(
                  title: 'Login',
                  margin: EdgeInsets.only(bottom: 50), onPressed: () { 
                          context.pushRoute(const DrawerMenu()); },
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
