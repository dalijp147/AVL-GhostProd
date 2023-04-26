import 'dart:ui';
import 'dart:math' show cos, sqrt, asin;
import '../Models/user.dart';
import 'package:map/pickLocationScreen.dart';
import 'package:map/provider/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:geolocator/geolocator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../models/changel.dart';

///OSM
class ClientMap extends StatefulWidget {
  @override
  _ClientMapState createState() => _ClientMapState();
}

class _ClientMapState extends State<ClientMap> {
  AppUser currUser = AppUser();
  List<MonumentMarker> changels = [];
  bool loading = false;
  bool trackUser = false;
  final PopupController _popupLayerController = PopupController();

  ///Client
  double userLat = 0.0;
  double userLng = 0.0;
  String phone = '98568456';
  String name = 'hsan';

  final MapController _mapController = MapController();

  /// user marker decla
  Marker userMarker = Marker(
    rotate: true,
    width: 0.0,
    height: 0.0,
    point: LatLng(0.0, 0.0),
    builder: (ctx) => Container(),
  );

  Future<void> requestPermissionLoc() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
  }

  @override
  void initState() {
    super.initState();

    /// get curr user from provider
    final provider =
        Provider.of<NavigationProviderUser>(context, listen: false);
    currUser = provider.user as AppUser;
    print(currUser.name);
    requestPermissionLoc();
  }

  Future<void> locateUser({bool? cameraFollow}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PickLocationView()),
    );
    if (!mounted) return;
    userLat = result.latitude;
    userLng = result.longitude;
    print('### user pos ==> $userLat - $userLng');
    userMarker = Marker(
      rotate: true,
      width: 140.0,
      height: 140.0,
      point: LatLng(userLat, userLng),
      builder: (ctx) => Container(
        child: const Icon(
          Icons.place,
          color: Colors.blue,
          size: 25,
        ),
      ),
    );

    /// add position to realTime
    addCurrLocToDB();

    /// stop loading
    setState(() {
      loading = false;
    });
    if (!cameraFollow!) {
      _mapController.move(LatLng(userLat, userLng), 16.0);
    }
    setState(() {});
  }

  /// share user location to FB
  Future addCurrLocToDB() async {
    DatabaseReference clients = FirebaseDatabase.instance.ref("/clients");
    final snapshot = await clients.get();

    /// get this from curr user
    Map<String, dynamic> client = {
      'phone': currUser.phone,
      'name': currUser.name,
      'pos': {
        "lat": '$userLat',
        "lng": '$userLng',
      }
    };
    try {
      var data = Map<String, dynamic>.from(snapshot.value as Map);
      print('clients number : ${data.length}');

      await clients.update({
        currUser.id: client,
      }).then((value) {
        // show snack
        Get.snackbar(
          "your location is visible now",
          "you can see changels markers",
        );

        /// load changelMarkers
        loadChangelMarkers();
      });
    } catch (e) {
      print('### $e');
      print('clients number : NULL}');

      await clients.update({
        currUser.id: client,
      }).then((value) {
        // show snack
        Get.snackbar(
          "your location is visible now",
          "you can see changels markers",
        );

        /// load changelMarkers
        loadChangelMarkers();
      });
    }
  }

  sendcurrentlocation() {}

  /// refresh changels
  loadChangelMarkers() async {
    changels.clear();

    DatabaseReference gpsRef = FirebaseDatabase.instance.ref('/changels');
    final snapshot = await gpsRef.get();
    var data = Map<String, dynamic>.from(snapshot.value as Map);

    data.forEach((key, value) {
      if (this.mounted) {
        setState(() {
          var lat = double.parse(data[key]['pos']['lat']);
          var lng = double.parse(data[key]['pos']['lng']);

          /// for getting changels markers
          AppUsr usrMarker = AppUsr(
            name: data[key]['name'],
            phone: data[key]['phone'],
            lat: lat,
            lng: lng,
          );
          changels.add(
            MonumentMarker(monument: usrMarker),
          );
        });
      }
    });

    print('### changel marker number: ${changels.length}');
  }

  ///################################################################

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('map'),
        backgroundColor: Colors.red,
      ),
      body: Container(
        child: Stack(
          children: [
            /// display map
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                interactiveFlags: InteractiveFlag.pinchZoom |
                    InteractiveFlag.drag |
                    InteractiveFlag.pinchMove |
                    InteractiveFlag.flingAnimation,

                center: LatLng(35.5812021, 10.7328324),
                zoom: 9.0,

                maxZoom: 17,
                //close
                minZoom: 1,
                //far
                onTap: (_, __) => _popupLayerController.hideAllPopups(),
              ),
              children: <Widget>[
                /// map_display
                TileLayerWidget(
                  options: TileLayerOptions(
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                    tileProvider: NonCachingNetworkTileProvider(),
                  ),
                ),

                ///markers /// user marker
                MarkerLayerWidget(
                    options: MarkerLayerOptions(
                  markers: <Marker>[
                    userMarker,
                  ],
                )),

                /// changels markers
                PopupMarkerLayerWidget(
                  options: PopupMarkerLayerOptions(
                    markers: changels,
                    popupController: _popupLayerController,
                    popupBuilder: (_, Marker marker) {
                      if (marker is MonumentMarker) {
                        return MonumentMarkerPopup(monument: marker.monument);
                      }
                      return const Card(child: Text('Not a monument'));
                    },
                  ),
                ),
              ],
            ),

            ///refresh
            Positioned(
              bottom: 30,
              left: 10,
              child: FloatingActionButton.extended(
                heroTag: "refresh",
                label: Row(
                  children: [
                    !loading
                        ? const Icon(
                            Icons.gps_fixed,
                            size: 24.0,
                            color: Colors.white,
                          )
                        : const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            )),
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Partager\nLocalisation',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.blue,
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  await locateUser(cameraFollow: false);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
