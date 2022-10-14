import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatelessWidget {
  static const _weekdayNamesTextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    color: Colors.grey,
    fontSize: 11,
  );

  final DateTime selectedDate;
  final OnDaySelected? onDaySelected;

  const CalendarWidget(
    this.selectedDate, {
    Key? key,
    this.onDaySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: TableCalendar(
          locale: Platform.localeName,
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: selectedDate,
          onDaySelected: onDaySelected,
          startingDayOfWeek: StartingDayOfWeek.monday,
          selectedDayPredicate: (day) => isSameDay(selectedDate, day),
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            leftChevronVisible: false,
            rightChevronVisible: false,
            headerMargin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekendStyle: _weekdayNamesTextStyle,
            weekdayStyle: _weekdayNamesTextStyle,
            dowTextFormatter: (date, locale) =>
                DateFormat.E(locale).format(date).toUpperCase(),
          ),
          calendarStyle: const CalendarStyle(
            isTodayHighlighted: false,
            defaultTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            weekendTextStyle: TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
            outsideTextStyle: TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),
        ),
      );
}
