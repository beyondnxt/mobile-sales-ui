import 'package:flutter/material.dart';
import 'package:lingam/const/app_sreen_size.dart';
import 'package:lingam/controller/task_provider.dart';
import 'package:lingam/widget/custom_text_field.dart';
import 'package:lingam/widget/loading_screen.dart';
import 'package:provider/provider.dart';

class SearchableDropDown extends StatefulWidget {
  final TextEditingController controller;
  final String? initialValue;
  final int? customerId;
  const SearchableDropDown(
      {super.key,
      required this.controller,
      required this.initialValue,
      required this.customerId});

  @override
  State<SearchableDropDown> createState() => _SearchableDropDownState();
}

class _SearchableDropDownState extends State<SearchableDropDown> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("${widget.initialValue} ${widget.customerId} ---- value");
    if (widget.customerId == null) {
    } else {
      searchController.text = widget.initialValue!;
      widget.controller.text = widget.customerId.toString();
      setState(() {

      });
    }
  }

  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  bool prefixIcon = false;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);
    return Column(
      children: [
        Container(
          height: ScreenSize.screenSize!.height * 0.06,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade200),
          child: TextFormField(
            readOnly: widget.customerId == null ? false : true,
            style: const TextStyle(
              color: Colors.black,
            ),
            focusNode: _focusNode,
            maxLines: 1,
            controller: searchController,
            decoration: InputDecoration(
                prefixIcon: const SizedBox(
                  height: 10,
                  width: 10,
                ),
                suffixIcon: IconButton(
                    onPressed:widget.customerId == null ? () {
                      prefixIcon = !prefixIcon;
                      if (prefixIcon == true) {
                        provider.searchQueryApi("");
                      }else{
 provider.searchCustomerName = [];


                      }
                      setState(() {});
                    }: null,
                    icon: Icon(prefixIcon
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down)),
                labelText: _isFocused
                    ? "Customer"
                    : searchController.text.isNotEmpty
                        ? null
                        : "Select Customer",
                contentPadding: EdgeInsets.only(top: 8),
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black))),
            onChanged: (val) {
              if (val.isNotEmpty) {
                provider.searchQueryApi(val);
              } else {

              }
            },
          ),
        ),
        provider.dropDownLoading && searchController.text.isNotEmpty
            ? Container(
                height: ScreenSize.screenSize!.height * 0.06,
                child: LoadingScreen())
            : searchController.text.isNotEmpty &&
                        provider.searchCustomerName.isNotEmpty ||
                    prefixIcon == true
                ?  Container(
                    height: ScreenSize.screenSize!.height * 0.3,
                    child: ListView.builder(
                        itemCount: provider.searchCustomerName.length,
                        itemBuilder: (ctx, index) {
                          return ListTile(
                            onTap: () {
                              searchController.text =
                                  provider.searchCustomerName[index].firstName!;
                              widget.controller.text = provider
                                  .searchCustomerName[index].id
                                  .toString();
                              provider.searchCustomerName = [];
                              prefixIcon = false;
                              setState(() {});
                            },
                            title: Text(
                                provider.searchCustomerName[index].firstName!),
                          );
                        }),
                  )
                :  Container()
      ],
    );
  }
}
