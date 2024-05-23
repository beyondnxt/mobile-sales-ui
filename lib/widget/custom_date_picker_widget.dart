import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lingam/controller/task_provider.dart';
import 'package:provider/provider.dart';

import '../const/app_sreen_size.dart';

class CustomDatePickerWidget extends StatefulWidget {
  const CustomDatePickerWidget({super.key});

  @override
  State<CustomDatePickerWidget> createState() => _CustomDatePickerWidgetState();
}

class _CustomDatePickerWidgetState extends State<CustomDatePickerWidget> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();

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

  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);
    return Container(
      height: ScreenSize.screenSize!.height * 0.06,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade200,
      ),
      child: TextFormField(
        readOnly: true,
        controller: provider.dateSelectController,
        style: const TextStyle(color: Colors.black),
        focusNode: _focusNode,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () async {
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: _selectedDate ?? DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (pickedDate != null && pickedDate != _selectedDate) {
                setState(() {
                  _selectedDate = pickedDate;
                  provider.dateSelectController.text =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                });
              }
            },
            icon: const Icon(Icons.calendar_today),
            color: Colors.black,
          ),
          prefixIcon: SizedBox(
            width: 20,
            height: 20,
          ),
          labelText: _isFocused
              ? "Follow up Dates"
              : _selectedDate == null &&
                      provider.dateSelectController.text.isEmpty
                  ? "Follow up Date"
                  : null,
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
