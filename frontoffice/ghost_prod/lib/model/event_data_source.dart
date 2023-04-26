import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';

import 'event.dart';

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Event> appointments) {
    this.appointments = appointments;
  }

  var _dataCollection = <DateTime, List<Appointment>>{};

  Event getEvent(int index) => appointments![index] as Event;
  @override
  DateTime getStartTime(int index) => getEvent(index).from;

  @override
  DateTime getEndTime(int index) => getEvent(index).to;

  @override
  String getSubject(int index) => getEvent(index).title;

  @override
  Color getColor(int index) => getEvent(index).backgroundColor;
  @override
  List<dynamic> getData(
      DateTime startDate, DateTime endDate, double startHour, double endHour) {
    String? _selectedFilter;
    // Filter the list of events based on the selected filter option
    if (_selectedFilter == 'All') {
      return appointments!
          .where((event) =>
              event.startTime.isAfter(startDate) &&
              event.endTime.isBefore(endDate))
          .toList();
    } else {
      return appointments!
          .where((event) =>
              event.startTime.isAfter(startDate) &&
              event.endTime.isBefore(endDate) &&
              event.title == _selectedFilter)
          .toList();
    }
  }

  @override
  Future<void> handleLoadMore(DateTime startDate, DateTime endDate) async {
    await Future.delayed(Duration(seconds: 1));
    final List<Appointment> meetings = <Appointment>[];
    DateTime appStartDate = startDate;
    DateTime appEndDate = endDate;

    while (appStartDate.isBefore(appEndDate)) {
      final List<Appointment>? data = _dataCollection[appStartDate];
      if (data == null) {
        appStartDate = appStartDate.add(Duration(days: 1));
        continue;
      }
      for (final Appointment meeting in data) {
        if (appointments!.contains(meeting)) {
          continue;
        }
        meetings.add(meeting);
      }
      appStartDate = appStartDate.add(Duration(days: 1));
    }
    appointments!.addAll(meetings);
    notifyListeners(CalendarDataSourceAction.add, meetings);
  }
}
