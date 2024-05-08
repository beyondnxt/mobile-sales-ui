import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lingam/const/app_sreen_size.dart';
import 'package:lingam/const/images.dart';
import 'package:lingam/controller/login_provider.dart';
import 'package:lingam/services/store_login_value.dart';
import 'package:lingam/widget/custom_elevated_button.dart';
import 'package:lingam/widget/custom_text_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "login_screen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLoginState().then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  Future<void> checkLoginState() async {
    if (mounted) {
      final prov = Provider.of<LoginProvider>(context, listen: false);
      String? email = await StoreLoginValue.getUserEmail();
      String? password = await StoreLoginValue.getUserPassword();
      if (email == null || password == null || email== ""|| password =="") {
      } else {
        print(email);
        print(password);
        prov.emailValidator(context, email, password);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: loginProvider.isLoading ? 0.5 : 1.0,
            child: SingleChildScrollView(
              child: SafeArea(
                child: Container(
                  width: ScreenSize.screenSize!.width,
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        CustomImagePath.logoPng,
                        width: ScreenSize.screenSize!.width * 0.5,
                        height: ScreenSize.screenSize!.height * 0.1,
                      ),
                      Image.asset(
                        CustomImagePath.loginBanner,
                        width: ScreenSize.screenSize!.width,
                        height: ScreenSize.screenSize!.height * 0.35,
                      ),
                      SizedBox(
                        height: ScreenSize.screenSize!.height * 0.01,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome Back 👋",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Text(
                            "Please enter details and login here",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.grey),
                          )
                        ],
                      ),
                      SizedBox(
                        height: ScreenSize.screenSize!.height * 0.02,
                      ),
                      CustomTextFormField(
                        controller: loginProvider.emailtextEditingController,
                        hintText: "Enter Email ID",
                        lableText: "Email ID",
                        prefixIcon: Icons.email_outlined,
                        suffixIcons: null,
                        textInputType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: ScreenSize.screenSize!.height * 0.02,
                      ),
                      CustomTextFormField(
                        controller: loginProvider.passwordtextEditingController,
                        hintText: "Enter Password",
                        lableText: "Password",
                        prefixIcon: Icons.lock_outline_rounded,
                        suffixIcons: Icons.visibility,
                        textInputType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: ScreenSize.screenSize!.height * 0.02,
                      ),
                      Container(
                        width: ScreenSize.screenSize!.width,
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            "Forget Password?",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: ScreenSize.screenSize!.height * 0.04,
                      ),
                      CustomElevatedButton(
                          onTap: () async {
                            if (loginProvider.isLoading) {
                            } else {
                              loginProvider.emailValidator(
                                  context,
                                  loginProvider.emailtextEditingController.text,
                                  loginProvider
                                      .passwordtextEditingController.text);
                            }
                          },
                          title: loginProvider.isLoading ? "Loading" : "Login")
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (loginProvider.isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
