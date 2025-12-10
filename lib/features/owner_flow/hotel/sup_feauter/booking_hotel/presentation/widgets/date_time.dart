import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class DateField extends StatelessWidget {
  final String label;
  final DateTime? selectedDate;
  final VoidCallback onTap;

  const DateField({
    super.key,
    required this.label,
    required this.selectedDate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(CupertinoIcons.calendar, color: Colors.grey.shade700),
            SizedBox(width: 10),
            Text(
              selectedDate == null
                  ? label
                  : DateFormat('dd/MM/yyyy').format(selectedDate!),
              style: TextStyle(
                fontSize: 16,
                color: selectedDate == null
                    ? Colors.grey.shade600
                    : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
Future<DateTime?> pickDate(BuildContext context) async {
  final today = DateTime.now();

  return await showDatePicker(
    context: context,
    initialDate: today,
    firstDate: today,
    lastDate: DateTime(2030),
  );
}
