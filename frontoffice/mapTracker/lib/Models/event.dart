import 'package:flutter/material.dart';

List<Event> eventFromJson(dynamic str) =>
    List<Event>.from((str).map((x) => Event.fromJson(x)));

class Event {
  late String title;

  late DateTime from;
  late DateTime to;
  late final Color backgroundColor;

  Event({
    required this.title,
    required this.from,
    required this.to,
    this.backgroundColor = Colors.red,
  });
  Event.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    from = json["start"];
    to = json["end"];
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'startdate': from,
      'enddate': to,
    };
  }
}
