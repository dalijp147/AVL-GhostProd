import 'package:flutter/material.dart';
import 'package:flutter_leaflet/flutter_leaflet.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Position _deliveryPosition;
  Marker _deliveryMarker;

  @override
  void initState() {
    super.initState();
    _getDeliveryLocation();
  }

  void _getDeliveryLocation() async {
    Position position = await Geolocator().getCurrentPosition();
    setState(() {
      _deliveryPosition = position;
      _deliveryMarker = Marker(
        point: LatLng(_deliveryPosition.latitude, _deliveryPosition.longitude),
        builder: (context) => Container(
          child: Icon(Icons.local_shipping, size: 50.0, color: Colors.red),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _deliveryPosition == null
            ? Center(child: CircularProgressIndicator())
            : LeafletMap(
                center: LatLng(_deliveryPosition.latitude, _deliveryPosition.longitude),
                zoom: 13.0,
                markers: [_deliveryMarker].toSet(),
              ),
      ),
    );
  }
}
