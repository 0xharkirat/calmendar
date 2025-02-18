import 'package:calmendar/src/models/calendar_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class CalendarController extends Notifier<CalendarState> {

  @override
  CalendarState build(){
    DateTime now = DateTime.now();
    return CalendarState(
      selectedDate: now,
      month: DateFormat('MMMM').format(now),
      dayName: DateFormat('E').format(now),
      year: now.year,
    );
  }

  void updateSelectedDate(DateTime selectedDate){
    state = state.copyWith(selectedDate: selectedDate);
  }
}

final calendarController = NotifierProvider<CalendarController, CalendarState>(( ) => CalendarController());