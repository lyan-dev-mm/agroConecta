import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const CalendarWidget({
    Key? key,
    required this.selectedDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: selectedDate,
      firstDay: DateTime(2020),
      lastDay: DateTime(2030),
      selectedDayPredicate: (day) => isSameDay(day, selectedDate),
      onDaySelected: (selected, focused) => onDateSelected(selected),
      calendarStyle: const CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Colors.orange,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
