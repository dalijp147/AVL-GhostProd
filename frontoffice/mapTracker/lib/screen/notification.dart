import 'dart:ui';

import 'package:flutter/material.dart';

import '../Models/notif.dart';
import 'package:blur/blur.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key, this.model}) : super(key: key);
  final Notificationf? model;

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.centerLeft,
        width: 150,
        height: 90.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(255, 39, 152, 183),
                Color.fromARGB(255, 30, 117, 141),
              ],
            )),
        child: Column(
          children: [
            Text(
              widget.model!.titre!,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white),
            ),
            Text(widget.model!.description!)
          ],
        ),
      ),
    );
  }
}
