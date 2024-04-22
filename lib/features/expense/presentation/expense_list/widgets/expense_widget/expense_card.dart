import 'package:flutter/material.dart';
import 'package:sales_app/core/basecomponents/base_responsive_widget.dart';
import 'package:sales_app/core/utils/helpers/app_configurations_helper/app_configurations_helper.dart';
import 'package:sales_app/core/utils/helpers/extension_functions/size_extension.dart';
import 'package:sales_app/core/utils/helpers/responsive_ui_helper/responsive_config.dart';
import 'package:sales_app/core/utils/values/styles.dart';
import 'package:sales_app/features/expense/domain/entities/expense_response_entity/expense_entity.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({
    Key? key,
    this.expenseEntity,
    this.onClickBox,
    this.isAdded,
  }) : super(key: key);
  final bool? isAdded;
  final ExpenseEntity? expenseEntity;
  final Function(ExpenseEntity? productEntity)? onClickBox;

  @override
  Widget build(BuildContext context) {
    final space = SizedBox(height: 5.h);
    return BaseResponsiveWidget(
      buildWidget: (BuildContext context, ResponsiveUiConfig responsiveUiConfig,
          AppConfigurations appConfigurations) {
        return GestureDetector(
          onTap: () {
            if (onClickBox != null) {
              onClickBox!(expenseEntity);
            }
          },
          child: Container(
            height: 60.w,
            width: responsiveUiConfig.screenWidth,
            margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: appConfigurations.appTheme.backgroundLightColor,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                ),
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10.w,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      expenseEntity?.expense ?? '',
                      style: poppinsRegular.copyWith(
                        fontSize: 16.w,
                        fontWeight: FontWeight.bold,
                        color: appConfigurations.appTheme.primaryColor,
                      ),
                    ),
                    Text(
                      "Status: Approved",
                      style: poppinsRegular.copyWith(
                        fontSize: 12.w,
                        color: appConfigurations.appTheme.primaryColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  expenseEntity?.date ?? '',
                  style: poppinsRegular.copyWith(
                    fontSize: 12.w,
                    fontWeight: FontWeight.bold,
                    color: appConfigurations.appTheme.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class RemoveWidget extends StatelessWidget {
  final void Function()? onTap;
  final bool isAdded;
  const RemoveWidget({Key? key, this.onTap, this.isAdded = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseResponsiveWidget(
      buildWidget: (BuildContext context, ResponsiveUiConfig responsiveUiConfig,
              AppConfigurations appConfigurations) =>
          Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          InkWell(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 10.w),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(.5),
                        offset: const Offset(1, 1),
                        spreadRadius: 1,
                        blurRadius: 1)
                  ],
                  color: isAdded
                      ? appConfigurations.appTheme.errorColor
                      : appConfigurations.appTheme.primaryColor,
                  borderRadius:
                      const BorderRadius.all(Radius.elliptical(5, 5))),
              child: Text(
                isAdded ? 'Remove' : 'Add',
                style: poppinsMedium.copyWith(
                  color: appConfigurations.appTheme.backgroundLightColor,
                  fontSize: 11.w,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QuantitySelector extends StatefulWidget {
  final AppConfigurations appConfigurations;
  const QuantitySelector({Key? key, required this.appConfigurations})
      : super(key: key);

  @override
  State<QuantitySelector> createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  int quantity = 1;

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Qty : ",
          style: poppinsRegular.copyWith(
            fontSize: 14.h,
            fontWeight: FontWeight.bold,
            color: widget.appConfigurations.appTheme.primaryColor,
          ),
        ),
        GestureDetector(
          onTap: decrementQuantity,
          child: Icon(
            Icons.remove_circle,
            size: 23.w,
            color: widget.appConfigurations.appTheme.primaryColor,
          ),
        ),
        SizedBox(
          width: 2.w,
        ),
        SizedBox(
          width: 30,
          child: TextField(
            controller: TextEditingController(text: '$quantity'),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
            decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
                isDense: true,
                contentPadding: EdgeInsets.all(0)),
          ),
        ),
        SizedBox(
          width: 2.w,
        ),
        GestureDetector(
            onTap: incrementQuantity,
            child: Icon(Icons.add_circle,
                size: 23.w,
                color: widget.appConfigurations.appTheme.primaryColor)),
      ],
    );
  }
}
