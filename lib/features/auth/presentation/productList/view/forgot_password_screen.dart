import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sales_app/core/basecomponents/base_responsive_widget.dart';
import 'package:sales_app/core/utils/helpers/app_configurations_helper/app_configurations_helper.dart';
import 'package:sales_app/core/utils/helpers/extension_functions/size_extension.dart';
import 'package:sales_app/core/utils/helpers/responsive_ui_helper/responsive_config.dart';
import 'package:sales_app/core/utils/values/styles.dart';
import 'package:sales_app/core/widgets/custom_field.dart';
import 'package:sales_app/core/widgets/custom_text_button.dart';
import 'package:sales_app/features/auth/presentation/productList/view/login_screen.dart';

enum Status { init, showPass }

@RoutePage()
class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({Key? key}) : super(key: key);

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  Status status = Status.init;
  @override
  Widget build(BuildContext context) {
    return BaseResponsiveWidget(
        initializeConfig: false,
        buildWidget: (BuildContext context,
            ResponsiveUiConfig responsiveUiConfig,
            AppConfigurations appConfigurations) {
          return Scaffold(
            backgroundColor: appConfigurations.appTheme.primaryColor,
            body: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    status == Status.init
                        ? "Reset Password by email"
                        : 'Enter the code from mail',
                    style: poppinsRegular.copyWith(
                      fontSize: 16.w,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  
               if( status == Status.showPass)
                       const Column(
                        children: [
                          CustomField(
                            iconUrl: 'assets/icon_password.png',
                            hint: 'Enter New Password',
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          CustomField(
                            iconUrl: 'assets/icon_password.png',
                            hint: 'Confirm Password',
                          )
                        ],
                      )
                      else const CustomField(
                          iconUrl: 'assets/icon_password.png',
                          hint: 'Enter Code',
                        ),
                  CustomTextButton(
                    title:
                        status  == Status.init ? 'Verify Code' : 'Set Password',
                    margin: const EdgeInsets.only(top: 50),
                    onPressed: () {
                      if (status == Status.init) {
                        status = Status.showPass;
                      } else if(status == Status.showPass){
                        context.back();
                      }
                      setState(() {});
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 30,
                      bottom: 74,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            context.back();
                          },
                          child: Text(
                            "Go back to Login",
                            style: poppinsRegular.copyWith(
                              fontSize: 12.w,
                              decorationStyle: TextDecorationStyle.dotted,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
