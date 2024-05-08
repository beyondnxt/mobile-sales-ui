import 'package:flutter/material.dart';

class CustomDropdownContainer extends StatefulWidget {
  final String hintText;
  final String lableText;
  final TextEditingController controller;
  final List<dynamic> dropDownValue;
  const CustomDropdownContainer({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.lableText,
    required this.dropDownValue,
  }) : super(key: key);

  @override
  _CustomDropdownContainerState createState() =>
      _CustomDropdownContainerState();
}

class _CustomDropdownContainerState extends State<CustomDropdownContainer> {
  String? _selectedValue;
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _obscureText = false;
  bool _isFocused = false;
  bool _isDropdownOpened = false;

  List<String> _dropdownItems = ['Option 1', 'Option 2', 'Option 3'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade200,
      ),
      child: DropdownButtonFormField<String>(
        itemHeight: MediaQuery.of(context).size.height * 0.06,
        padding: EdgeInsets.all(0),
        icon: Padding(
          padding: const EdgeInsets.only(
            right: 20,
          ),
          child: Icon(Icons.keyboard_arrow_down),
        ),
        value: _selectedValue,
        onChanged: (String? value) {
          setState(() {
            _selectedValue = value;
            print(_selectedValue);
            widget.controller.text = _selectedValue!;
          });
        },
        onTap: () {
          setState(() {
            _isDropdownOpened = true;
          });
        },
        onSaved: (String? value) {
          setState(() {
            _isDropdownOpened = false;
          });
        },
        items: widget.dropDownValue.map((dynamic value) {
          return DropdownMenuItem<String>(
            value: value.id.toString(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.06,
              child: Text(
                value.firstName,
              ),
            ),
          );
        }).toList(),
        decoration: InputDecoration(
          prefixIcon: Container(
            height: 20,
            width: 20,
          ),
          labelText: _isFocused
              ? widget.lableText
              : _selectedValue != null
                  ? null
                  : widget.hintText,
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 12),
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
