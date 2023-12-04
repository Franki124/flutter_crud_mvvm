import 'package:flutter/material.dart';

class LabelTextField extends StatelessWidget {
  final String defaultText;
  final TextEditingController controller;
  final TextInputType inputType;
  final bool readOnly;

  const LabelTextField({Key? key, required this.defaultText, required this.controller, required this.inputType, required this.readOnly}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: TextField(
        keyboardType: inputType,
        controller: controller,
        readOnly: readOnly,
        decoration: InputDecoration(
            labelText: defaultText,
            labelStyle: const TextStyle(color: Colors.blue),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue))),
      ),
    );
  }
}