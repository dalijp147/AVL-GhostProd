
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:math' as math;

import 'package:url_launcher/url_launcher.dart';

class AppUsr {
  //for marker
  static const double size = 25;

   String name;
   String phone;

   double lat;
   double lng;

  AppUsr({
    required this.name,
    required this.phone,
    required  this.lat,
    required this.lng,
  });
}




class MonumentMarker extends Marker {
  MonumentMarker({required this.monument})
      : super(
    anchorPos: AnchorPos.align(AnchorAlign.top),
    height: AppUsr.size,
    width: AppUsr.size,
    point: LatLng(monument.lat, monument.lng),
    builder: (BuildContext ctx) => const Icon(Icons.place,color: Colors.redAccent,),
  );

  final AppUsr monument;
}

class MonumentMarkerPopup extends StatelessWidget {
  const MonumentMarkerPopup({Key? key, required this.monument})
      : super(key: key);
  final AppUsr monument;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        launch("tel://${monument.phone}");
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(monument.name,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20,
                color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0)

              ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(monument.phone),
              ),
              //Text('${monument.lat}-${monument.lng}'),
            ],
          ),
        ),
      ),
    );
  }
}