import 'package:flutter/material.dart';

import '../reusables/paints.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final String? initialValue;
  final String hint;
  final IconData? icon;
  final ValueChanged<String?> onChanged;
  const CustomDropdown({
    Key? key,
    required this.items,
    this.initialValue,
    required this.hint,
    required this.onChanged,
    this.icon,
  }) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue; // Set the initial value
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        color: PaintColors.paralexVeryLightGrey,
        // border: Border.all(color: PaintColors.paralexTransparent, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          children: [
            SizedBox(
              width: 8,
            ),
            Icon(widget.icon),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: DropdownButton<String>(
                value: selectedValue,
                hint: Text(widget.hint),
                dropdownColor: PaintColors.paralexVeryLightGrey,
                isExpanded: true,
                items: widget.items.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue; // Update the selected value
                  });
                  widget.onChanged(newValue); // Notify parent widget
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
