import 'package:calmendar/src/models/calendar_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class CalendarController extends Notifier<CalendarState> {
  @override
  CalendarState build() {
    DateTime now = DateTime.now();
    return CalendarState(
      selectedDate: now,
      month: DateFormat('MMMM').format(now),
      dayName: DateFormat('E').format(now),
      year: now.year,
    );
  }

  void updateSelectedDate(DateTime selectedDate) {
    state = state.copyWith(selectedDate: selectedDate);
  }

  // return days in the month
  int daysInMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0).day;
  }

  // return first day of month
  DateTime firstDayOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  // return list of days in the week
  List<String> get weekdays {
    return ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  }

  // return selected weekday index
  int get selectedWeekdayIndex {
    return state.selectedDate.weekday - 1;
  }

  // Function to update the selected date by month
  void updateSelectedMonth(
      DateTime currentDate, int monthOffset) {
    int currentDay = currentDate.day;
    DateTime newDate =
        DateTime(currentDate.year, currentDate.month + monthOffset, 1);

    // Find the last valid day in the new month
    int lastDayInNewMonth = DateTime(newDate.year, newDate.month + 1, 0).day;

    // Ensure we don't exceed the last valid day
    int newDay =
        (currentDay > lastDayInNewMonth) ? lastDayInNewMonth : currentDay;

    // Update state
    updateSelectedDate(DateTime(newDate.year, newDate.month, newDay));
  }
}

final calendarController = NotifierProvider<CalendarController, CalendarState>(
    () => CalendarController());
