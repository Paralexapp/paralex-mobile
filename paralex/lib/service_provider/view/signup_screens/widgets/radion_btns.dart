import 'package:flutter/material.dart';

class ReusableRadioButtons extends StatefulWidget {
  final List<String> options;
  final String? initialValue;
  final Function(String?)? onChanged;
  final String label;

  const ReusableRadioButtons(
      {Key? key,
      required this.options,
      this.initialValue,
      required this.onChanged,
      required this.label})
      : super(key: key);

  @override
  _ReusableRadioButtonsState createState() => _ReusableRadioButtonsState();
}

class _ReusableRadioButtonsState extends State<ReusableRadioButtons> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label, // Display label
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: widget.options.map((option) {
            return Expanded(
              child: ListTile(
                title: Text(option),
                contentPadding: EdgeInsets.zero,
                leading: Radio(
                  value: option,
                  groupValue: _selectedValue,
                  onChanged: (value) {
                    widget.onChanged!(value as String?);
                    setState(() => _selectedValue = value);
                  },
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
