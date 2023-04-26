import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:map/Models/db.dart';
import 'package:map/Models/location.dart';
import 'package:provider/provider.dart';

import 'provider/location_provider.dart';

class PickLocationView extends StatefulWidget {
  const PickLocationView({Key? key}) : super(key: key);

  @override
  State<PickLocationView> createState() => _PickLocationViewState();
}

class _PickLocationViewState extends State<PickLocationView> {
  LatLng pickedPos = LatLng(0, 0);
  DB? dbHelper = DB();

  void saveData(String latitude, String longitude) {
    dbHelper!
        .insert(
      LocationP(
        latitude: latitude,
        longitude: longitude,
      ),
    )
        .then((value) {
      print(value);
      print('location Added ');
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('pick location'),
      ),
      body: Consumer<LocationProvider>(builder: (context, locations, child) {
        return FlutterLocationPicker(
            initPosition: LatLong(23, 89), // initial pos
            selectLocationButtonStyle: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
            ),
            selectLocationButtonText: 'Set Current Location',
            initZoom: 11,
            minZoomLevel: 5,
            maxZoomLevel: 16,
            trackMyPosition: true,
            onError: (e) => print(e),
            onPicked: (pickedData) {
              pickedPos = LatLng(
                  pickedData.latLong.latitude, pickedData.latLong.longitude);
              saveData(pickedData.latLong.latitude.toString(),
                  pickedData.latLong.longitude.toString());
              print(pickedData.latLong.latitude);
              print(pickedData.latLong.longitude);
              print(pickedData.address);

              print(locations);
              Navigator.pop(context, pickedPos);
            });
      }),

      /// add_categ button
    );
  }
}
