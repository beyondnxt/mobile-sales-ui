import 'package:flutter/material.dart';
import 'package:sales_app/core/utils/helpers/app_configurations_helper/app_configurations_helper.dart';
import 'package:sales_app/core/utils/helpers/extension_functions/size_extension.dart';
import 'package:sales_app/core/utils/values/styles.dart';

class CustomField extends StatelessWidget {
  final String iconUrl;
  final String hint;

  const CustomField({
    super.key,
    this.iconUrl = '',
    this.hint = '',
  });

  @override
  Widget build(BuildContext context) {
    AppConfigurations appConfigurations = AppConfigurations();
    return Container(
      height: 54,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 15),
      decoration: BoxDecoration(color: Colors.white,
        border: Border.all(
        color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Container(
            height: 26,
            width: 26,
            margin: const EdgeInsets.only(right: 18),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  iconUrl,
                ),
              ),
            ),
          ),
          Expanded(
            child: TextFormField(
              decoration: InputDecoration.collapsed(
                
                hintText: hint,
                hintStyle: poppinsRegular.copyWith(
                  fontSize: 12.w,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.withOpacity(.5),
                ),
              ),
              style: poppinsRegular.copyWith(
                fontSize: 12.w,
                fontWeight: FontWeight.bold,
                color: appConfigurations.appTheme.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
