// State model for the calendar
import 'package:intl/intl.dart';

class CalendarState {
  final DateTime selectedDate;
  final String month;
  final String dayName;
  final int year;

  CalendarState({
    required this.selectedDate,
    required this.month,
    required this.dayName,
    required this.year,
  });

  // Method to update the selected date
  CalendarState copyWith({DateTime? selectedDate}) {
    return CalendarState(
      selectedDate: selectedDate ?? this.selectedDate,
      month: DateFormat('MMMM').format(selectedDate ?? this.selectedDate),
      dayName: DateFormat('E').format(selectedDate ?? this.selectedDate),
      year: (selectedDate ?? this.selectedDate).year,
    );
  }

  // to string
  @override
  String toString() {
    return 'CalendarState(selectedDate: $selectedDate, month: $month, dayName: $dayName, year: $year)';
  }
}