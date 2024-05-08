import 'package:flutter/material.dart';

import '../const/app_sreen_size.dart';

class CustomTextFormField extends StatefulWidget {
  final String? hintText;
  final String lableText;
  final TextEditingController controller;
  final IconData? prefixIcon;
  final IconData? suffixIcons;
  final TextInputType textInputType;

  const CustomTextFormField(
      {super.key,
      required this.hintText,
      required this.lableText,
      required this.controller,
      required this.prefixIcon,
      required this.suffixIcons,
      required this.textInputType});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    if (widget.suffixIcons != null) {
      _obscureText = true;
    }
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenSize.screenSize!.height * 0.06,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.grey.shade200),
      child: TextFormField(
        style: const TextStyle(
          color: Colors.black,
        ),
        focusNode: _focusNode,
        controller: widget.controller,
        obscureText: _obscureText,
        obscuringCharacter: '*',
        decoration: InputDecoration(
            prefixIcon: widget.prefixIcon == null
                ? const SizedBox(
                    height: 10,
                    width: 10,
                  )
                : Icon(
                    widget.prefixIcon,
                    color: Colors.black,
                  ),
            suffixIcon: widget.suffixIcons == null
                ? const SizedBox(height: 10)
                : IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: _obscureText
                        ? const Icon(Icons.visibility_off_outlined)
                        : const Icon(Icons.visibility_outlined)),
            labelText: _isFocused
                ? widget.lableText
                : widget.controller.text.isNotEmpty
                    ? null
                    : widget.hintText,
            contentPadding: EdgeInsets.all(0),
            border: InputBorder.none,
            errorBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black))),
      ),
    );
  }
}
