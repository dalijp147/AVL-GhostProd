import 'package:flutter/material.dart';
import 'package:ghost_prod/model/product.dart';
import 'package:ghost_prod/provider/event_provider.dart';
import 'package:ghost_prod/screens/EventEditingPage.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../model/event.dart';
import '../model/event_data_source.dart';
import '../widget/tasks_widget.dart';

class CAlenderSc extends StatefulWidget {
  const CAlenderSc({Key? key}) : super(key: key);

  @override
  State<CAlenderSc> createState() => _CAlenderScState();
}

class _CAlenderScState extends State<CAlenderSc> {
  String? value;
  String? _selectedFilter;
  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          // Add the combobox widget
          DropdownButton(
            value: _selectedFilter,
            onChanged: (newValue) {
              setState(() {
                _selectedFilter = newValue as String?;
              });
            },
            items: [
              DropdownMenuItem(
                value: 'all',
                child: Text('all'),
              ),
              DropdownMenuItem(
                value: 'equipement sony',
                child: Text('equipement sony'),
              ),
              DropdownMenuItem(
                value: 'equipement canon',
                child: Text('equipement canon'),
              ),
              DropdownMenuItem(
                value: 'equipement malek',
                child: Text('equipement malek'),
              ),
            ],
          ),
          Expanded(
            child: SfCalendar(
              dataSource: _selectedFilter == 'all'
                  ? EventDataSource(events)
                  : EventDataSource(events
                      .where((element) => element.title == _selectedFilter)
                      .toList()),
              view: CalendarView.month,
              initialDisplayDate: DateTime.now(),
              cellBorderColor: Color.fromARGB(0, 243, 0, 0),
              monthViewSettings: MonthViewSettings(
                appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
              ),
              controller: _controller,
              onLongPress: (details) {
                final provider =
                    Provider.of<EventProvider>(context, listen: false);
                provider.setData(details.date!);
                showModalBottomSheet(
                    context: context, builder: (context) => TasksWidget());
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.red,
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => EventEditingPage())),
      ),
    ));
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );
}
