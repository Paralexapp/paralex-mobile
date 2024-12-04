import 'package:flutter/material.dart';

import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:intl/intl.dart';

class ReusableDatePicker extends StatefulWidget {
  final Function(DateTime?)? onDateChanged;
  final String labelText;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final TextEditingController? controller;
  final Text? label;

  const ReusableDatePicker(
      {super.key,
      required this.onDateChanged,
      this.initialDate,
      this.firstDate,
      this.lastDate,
      this.controller,
      required this.labelText,
      this.label});

  @override
  _ReusableDatePickerState createState() => _ReusableDatePickerState();
}

class _ReusableDatePickerState extends State<ReusableDatePicker> {
  DateTime? _selectedDate;

  final DateFormat _dateFormat = DateFormat("yyyy-MM-dd");

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller ??
          TextEditingController(
              text: _dateFormat.format(_selectedDate ?? DateTime.now())),
      readOnly: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFECF1F4),
        labelText: widget.labelText,
        border: const OutlineInputBorder(
          // borderSide: BorderSide(color: Color(0xFF4C1044), width: 2.0),
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: Icon(Icons.calendar_today),
      ),
      onTap: () async {
        final DateTime? picked = await DatePicker.showSimpleDatePicker(
          context,
          initialDate: _selectedDate ?? DateTime.now(),
          firstDate: widget.firstDate ?? DateTime(1900),
          lastDate: widget.lastDate ?? DateTime(2030),
          dateFormat: "dd-MMMM-yyyy",
          locale: DateTimePickerLocale.en_us,
          looping: true,
        );
        if (picked != null) {
          widget.onDateChanged!(picked);
          setState(() {
            _selectedDate = picked;
            widget.controller?.text = _dateFormat.format(picked);
          });
        }
      },
    );
  }
}
