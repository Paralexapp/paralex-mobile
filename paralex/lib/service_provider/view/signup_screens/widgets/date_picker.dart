import 'package:flutter/material.dart';

class ReusableDatePicker extends StatefulWidget {
  final Function(DateTime?)? onDateChanged;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const ReusableDatePicker({
    Key? key,
    required this.onDateChanged,
    this.initialDate,
    this.firstDate,
    this.lastDate,
  }) : super(key: key);

  @override
  _ReusableDatePickerState createState() => _ReusableDatePickerState();
}

class _ReusableDatePickerState extends State<ReusableDatePicker> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      decoration: const InputDecoration(
        // labelText: 'Date',
        border: OutlineInputBorder(),
      ),
      onTap: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: _selectedDate ?? DateTime.now(),
          firstDate: widget.firstDate ?? DateTime(2000),
          lastDate: widget.lastDate ?? DateTime(2030),
        );
        if (pickedDate != null) {
          widget.onDateChanged!(pickedDate);
          setState(() => _selectedDate = pickedDate);
        }
      },
      controller: TextEditingController(text: _selectedDate.toString()),
    );
  }
}
