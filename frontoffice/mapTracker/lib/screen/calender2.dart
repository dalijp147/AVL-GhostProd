import 'package:flutter/material.dart';
import '../Models/product.dart';
import '../Service/api_service.dart';
import '../provider/event_provider.dart';
import '../screen/EventEditingPage.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../Models/event.dart';
import '../Models/event_data_source.dart';
import '../widget/tasks_widget.dart';

class CAlenderSc extends StatefulWidget {
  const CAlenderSc({Key? key, this.name}) : super(key: key);

  final String? name;
  @override
  State<CAlenderSc> createState() => _CAlenderScState();
}

class _CAlenderScState extends State<CAlenderSc> {
  String? value;
  String? _selectedFilter;
  List<Event> _events = [];
  late List<Appointment?> appointments;
  @override
  void initState() {
    super.initState();
    appointments = [];
    // APIService.getEvents(widget.model!.name!).then((value) {
    //   setState(() {
    //     _events = value;
    //   });
    // });
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    try {
      final events = await APIService.getEvents(widget.name!);
      setState(() {
        _events = events;
      });
    } catch (e) {
      print('Failed to fetch events: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    late CalendarDataSource dataSource;

    if (_events != null) {
      dataSource = EventDataSource(_events);
    }

    CalendarController _controller = CalendarController();
    String _text = '';
    final Event? event;
    final items = ['Items 1 ', 'Item 2'];

//list of count
    final events = Provider.of<EventProvider>(context).events;
    final selected = Provider.of<EventProvider>(context).selectedData;

    int index = 0;
    return SafeArea(
      child: Scaffold(
        body: SfCalendar(
          view: CalendarView.month,
          dataSource: _CalendarDataSource(_events),
          initialDisplayDate: DateTime.now(),

          monthViewSettings: MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
          ),

          // other calendar configuration options...
        ),
      ),
    );
  }
}

class _CalendarDataSource extends CalendarDataSource {
  _CalendarDataSource(List<Event> events) {
    appointments = events.map((event) {
      return Appointment(
        startTime: event.from,
        endTime: event.to,
        subject: event.title,
      );
    }).toList();
  }
}
