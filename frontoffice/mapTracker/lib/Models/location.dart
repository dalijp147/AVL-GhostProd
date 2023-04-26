import 'package:flutter/material.dart';

class LocationP with ChangeNotifier {
  final String? latitude;
  final String? longitude;

  LocationP({
    this.latitude,
    this.longitude,
  });
  LocationP.fromMap(Map<dynamic, dynamic> data)
      : latitude = data['latitude'],
        longitude = data['longitude'];

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
