import 'package:flutter/material.dart';
import 'package:map/models/event.dart';
import '../models/event_data_source.dart';
import '../provider/event_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TasksWidget extends StatefulWidget {
  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
    final selectedEvents = provider.eventsofSelectedDate;
    if (selectedEvents.isEmpty) {
      return Center(
        child: Text('No events found'),
      );
    }
    ;
    return SfCalendar(
      view: CalendarView.timelineDay,
      dataSource: EventDataSource(provider.events.cast<Event>()),
      initialDisplayDate: provider.selectedData,
      appointmentBuilder: appointmentBuilder,
    );
  }

  Widget appointmentBuilder(
      BuildContext context, CalendarAppointmentDetails details) {
    final event = details.appointments.first;
    return Container(
      width: details.bounds.width,
      height: details.bounds.height,
      decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        event.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Color.fromARGB(255, 255, 0, 0),
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
