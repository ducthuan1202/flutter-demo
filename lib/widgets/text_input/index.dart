import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {

  final String name;
  final String initialValue;
  final String? helperText;
  final String? hintText;
  final int? maxLength;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final TextCapitalization textCapitalization;

  const TextInput({
    Key? key,
    required this.name,
    required this.initialValue,
    this.hintText,
    this.helperText,
    this.validator,
    this.onChanged,
    this.controller,
    this.maxLength,
    this.textCapitalization = TextCapitalization.none,
  }) : super(key: key);

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        helperText: widget.helperText,
        hintText: widget.hintText
      ),
      // initialValue: widget.initialValue,
      validator: widget.validator,
      onChanged: widget.onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLength: widget.maxLength,
      textCapitalization: widget.textCapitalization,
    );
  }
}
