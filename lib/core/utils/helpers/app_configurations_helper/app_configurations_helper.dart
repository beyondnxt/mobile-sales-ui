import 'package:injectable/injectable.dart';
import 'package:sales_app/core/di/app_component/app_component.dart';
import 'package:sales_app/core/utils/helpers/app_flavor_helper/app_flavors_helper.dart';
import 'package:sales_app/core/utils/helpers/app_theme_helper/custom_theme_data.dart';
import 'package:sales_app/core/utils/values/colors.dart';

@singleton
class AppConfigurations {
  String? baseUrl = locator<AppBaseFlavorsHelper>().baseUrl;
  CustomThemeData appTheme = CustomThemeData(
    buttonEnabledColor: blue2F4FCD,
    buttonDisabledColor: blueD8E7F2,
    primaryColor: blue203C6F,
    validColor: green27B15F,
    secondaryColor: blueF1F4F,
    thirdColor: blueD8E7F2,
    backgroundLightColor: white,
    backgroundGreyColor: greyE5E5EA,
    errorColor: redCF3A3A,
    loaderColor: blue203C6F,
    subTitleTextColor: black404040,
    titleTextColor: black101010,
  );
}
