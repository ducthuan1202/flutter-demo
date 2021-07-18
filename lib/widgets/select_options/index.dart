import 'package:flutter/material.dart';
import 'package:untitled/utils/form_helpers.dart';

class SelectOptions extends StatefulWidget {

  final String name;
  final String? initialValue;
  final String? placeholder;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String?>? onChanged;
  final List<Map<String, String>> dataSource;

  const SelectOptions({
    Key? key,
    required this.name,
    required this.initialValue,
    this.placeholder,
    this.validator,
    this.onChanged,
    required this.dataSource,
  }) : super(key: key);

  @override
  _SelectOptionsState createState() => _SelectOptionsState();
}

class _SelectOptionsState extends State<SelectOptions> {
  @override
  Widget build(BuildContext context) {

    return DropdownButtonFormField(
      isExpanded: true,
      value: widget.initialValue,
      validator: widget.validator,
      onChanged: widget.onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      items: buildDropdownItems(drawData: widget.dataSource, label: widget.placeholder),
    );
  }
}
