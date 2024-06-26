import 'package:flutter/material.dart';


Future<DateTime?> buildCustomShowDatePicker(BuildContext context,
    {DateTime? firstDate, DateTime? lastDate, DateTime? initialDate}) {
  return showDatePicker(
    context: context,
    initialDate: initialDate ?? DateTime.now(),
    firstDate:firstDate?? DateTime.parse('1950-05-03'),
    lastDate: DateTime.parse('2070-05-03'),
  );
}
