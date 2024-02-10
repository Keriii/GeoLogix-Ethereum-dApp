import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

//https://api.mapbox.com/styles/v1/natrix/ckg6wnrz7114z19nwrt4j8taw/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibmF0cml4IiwiYSI6ImNrM2FkeXZhZzBhdGgzZ21ycGM0bzd1MXIifQ.RWcyUBbXiv2jbzebgNNdSA
class MapPage extends ConsumerStatefulWidget {
  final String address;
  const MapPage(this.address, {super.key});
  static const String ACCESS_TOKEN =
      "pk.kahropsurtLIUE45IiwiYSI6ImNrM2FkeXZhZzBhdGgzZ21ycGM0bzd1MXIifQ.RWcyUBbXivkeryshvds4";

  @override
  ConsumerState<MapPage> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  bool isTrackingEnabled = false;
  String employeeAdress = "";

  latlng.LatLng startingCoord = latlng.LatLng(7.052977, 38.486543);

  Map<String, dynamic> contractInfo = {};
  bool hasContract = false;

  List<Marker> markers = [];
  late Timer timer;

  var d;

  @override
  void initState() {
    // TODO: implement initState
    initLocation();
    super.initState();
  }

  @override
  void dispose() {
    try {
      timer.cancel();
    } catch (e) {}
    super.dispose();
  }

  void initLocation() async {
    PermissionStatus st = await checkPermission();
    if (st == PermissionStatus.granted) {
      Position? position = await getCurrentLocation();
      if (position != null) {
        latlng.LatLng v = latlng.LatLng(position.latitude, position.longitude);
        List<Marker> m = [
          Marker(
            width: 40,
            height: 40,
            point: v,
            builder: (context) => const Icon(
              Icons.location_history,
              color: Colors.black54,
            ),
          )
        ];
        setState(() {
          startingCoord = v;
          markers = m;
        });
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: errorColor,
          content: Text(
            "Location Error",
            style: TextStyle(
              fontSize: 15,
              color: primaryColor,
            ),
          ),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ));
      }
    } else {
      await LocationPermissions().requestPermissions();
      initLocation();
    }
  }

  Future<Position?> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium);
      return position;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
