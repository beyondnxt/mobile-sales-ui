import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sales_app/core/basecomponents/base_responsive_widget.dart';
import 'package:sales_app/core/basecomponents/base_view_model_view.dart';
import 'package:sales_app/core/commundomain/entitties/based_api_result/api_result_state.dart';
import 'package:sales_app/core/commundomain/entitties/based_api_result/error_result_model.dart';
import 'package:sales_app/core/utils/auto_router_setup/auto_router.gr.dart';
import 'package:sales_app/core/utils/helpers/app_configurations_helper/app_configurations_helper.dart';
import 'package:sales_app/core/utils/helpers/responsive_ui_helper/responsive_config.dart';
import 'package:sales_app/features/companies/domain/entities/company_response_entity/company_info_entity.dart';
import 'package:sales_app/features/companies/presentation/companyList/company_details_viewmodel.dart';
import 'package:sales_app/features/companies/presentation/companyList/widgets/add_lead/add_lead.dart';
import 'package:sales_app/features/companies/presentation/companyList/widgets/company_tile/company_tile_widget.dart';
import 'package:sales_app/features/companies/presentation/companyList/widgets/serach_company/search_company_widget.dart';

@RoutePage()
class CompanyListView extends StatefulWidget {
  final bool isLead;
  const CompanyListView({Key? key, this.isLead = false}) : super(key: key);

  @override
  State<CompanyListView> createState() => _CompanyListViewState();
}

class _CompanyListViewState extends State<CompanyListView> {
  final List<CompanyInfoEntity?> _companyList = <CompanyInfoEntity?>[];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  CompanyListViewModel? _provider;

  void _listenToInitialLocalData() {
    _provider?.companyResult.stream
        .listen((ApiResultState<List<CompanyInfoEntity?>?>? result) {
      result?.when(
        data: (List<CompanyInfoEntity?>? data) {
          if (data != null) {
            if (!mounted) {
              return;
            }
            setState(() {
              _companyList.addAll(data);
            });
          }
        },
        error: (ErrorResultModel error) {},
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseResponsiveWidget(
      initializeConfig: true,
      buildWidget: (BuildContext context, ResponsiveUiConfig responsiveUiConfig,
              AppConfigurations appConfigurations) =>
          Scaffold(
        backgroundColor: appConfigurations.appTheme.backgroundLightColor,
        floatingActionButton: (widget.isLead)
            ? FloatingActionButton(
                foregroundColor:
                    appConfigurations.appTheme.backgroundLightColor,
                backgroundColor: appConfigurations.appTheme.primaryColor,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AddLeadWidget(
                        onTapFunction: () async {
                          // if (_controller.text.isNotEmpty && !_checkItemInList()) {
                          //   await _provider?.getWeatherByCity(
                          //       cityName: _controller.text);
                          // }
                        },
                      );
                    },
                  );
                },
                child: const Icon(
                  Icons.add,
                ),
              )
            : null,
        body: SafeArea(
          child: BaseViewModelView<CompanyListViewModel>(
            onInitState: (CompanyListViewModel provider) async {
              _provider = provider;
              _listenToInitialLocalData();
              await provider.getAllLocalCompanies();
            },
            buildWidget: (CompanyListViewModel provider) {
              return Column(
                children: [
                  SearchCompanyWidget(
                      controller: _controller, onTapFunction: () {}),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: _companyList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _companyList.isNotEmpty
                            ? CompanyDetailsTileWidget(
                                onClickBox:
                                    (CompanyInfoEntity? companyInfoEntity) {
                                  context.pushRoute(
                                    CompanyDetailsView(
                                        companyInfoEntity: companyInfoEntity),
                                  );
                                },
                                companyInfoEntity: _companyList[index],
                              )
                            : Container();
                      }),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
