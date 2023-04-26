import 'package:flutter/cupertino.dart';
import '../Models/event.dart';

class EventProvider extends ChangeNotifier {
  final List<Event> _events = [];
  List<Event> get events => _events;
  DateTime _selectedData = DateTime.now();
  DateTime get selectedData => _selectedData;
  void setData(DateTime date) => _selectedData = date;
  List<Event> get eventsofSelectedDate => _events;
  void addEvent(Event event) {
    _events.add(event);
    notifyListeners();
  }

  ///this method will prevent the override of toString

}
