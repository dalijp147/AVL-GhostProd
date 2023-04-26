import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:map/Service/api_service.dart';
import '../Models/event.dart';
import '../Models/product.dart';
import '../controller/config.dart';
import '../utils.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../provider/event_provider.dart';

class EventEditingPage extends StatefulWidget {
  final Event? event;

  const EventEditingPage({this.event});

  @override
  State<EventEditingPage> createState() => _EventEditingPageState();
}

class _EventEditingPageState extends State<EventEditingPage> {
  final _formkey = GlobalKey<FormState>();
  late DateTime fromDate;
  late DateTime toDate;
  final titleController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now().add(Duration(hours: 2));
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  static var client = http.Client();

  List<String> productNames = [];

  String? value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
        actions: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            onPressed: () {
              APIService.saveevent(
                  Utils.toDate(fromDate), Utils.toDate(toDate));
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.done),
            label: Text('save'),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(13),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 12,
              ),
              Column(
                children: [
                  buildHeader(
                    header: 'From',
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: builedDropDownField(
                              text: Utils.toDate(fromDate),
                              onClicked: () =>
                                  pickFromDateTime(pickDate: true)),
                        ),
                        Expanded(
                          child: builedDropDownField(
                            text: Utils.toTime(fromDate),
                            onClicked: () => pickFromDateTime(pickDate: false),
                          ),
                        )
                      ],
                    ),
                  ),
                  buildHeader(
                    header: 'To',
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: builedDropDownField(
                            text: Utils.toDate(toDate),
                            onClicked: () => pickToDateTime(pickDate: true),
                          ),
                        ),
                        Expanded(
                          child: builedDropDownField(
                            text: Utils.toTime(toDate),
                            onClicked: () => pickToDateTime(pickDate: false),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future pickFromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(fromDate, pickDate: pickDate);
    if (date == null) return;
    if (date.isAfter(toDate)) {
      toDate =
          DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }
    setState(() => fromDate = date);
  }

  Future pickToDateTime({required bool pickDate}) async {
    final date = await pickDateTime(
      toDate,
      pickDate: pickDate,
      firstDate: pickDate ? fromDate : null,
    );
    if (date == null) return;

    setState(() => toDate = date);
  }

  Future<DateTime?> pickDateTime(
    DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate ?? DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (date == null) return null;
      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);
      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
          context: context, initialTime: TimeOfDay.fromDateTime(initialDate));
      if (timeOfDay == null) return null;
      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
      return date.add(time);
    }
  }

  Widget builedDropDownField({
    required String text,
    required VoidCallback onClicked,
  }) =>
      ListTile(
        title: Text(text),
        trailing: Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );
  Widget buildHeader({required String header, required Widget child}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(header), child],
      );
  Future saveForm() async {
    final isValid = _formkey.currentState!.validate();
    if (isValid) {
      final event = Event(
        title: value.toString(),
        from: fromDate,
        to: toDate,
      );

      final provider = Provider.of<EventProvider>(context, listen: false);
      provider.addEvent(event as Event);

      Navigator.of(context).pop();
    }
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );
}
