import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  List<LatLng> tappedPoints = [];

  Widget build(BuildContext context) {
    var markers = tappedPoints.map((latlng) {
      print("lat ${latlng.latitude} long ${latlng.longitude}");
      return new Marker(
        width: 80.0,
        height: 80.0,
        point: latlng,
        builder: (ctx) => new Container(
          child: Icon(Icons.location_on,
        ),
      ));
    }).toList();

    return new Scaffold(
      body: new Padding(
        padding: new EdgeInsets.all(4.0),
        child: new Column(
          children: [
            new Padding(
              padding: new EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: new Text(""),
            ),
            new Flexible(
              child: new FlutterMap(
                options: new MapOptions(
                    center: new LatLng(26.2006, 92.9376),
                    zoom: 7.0,
                    ),
                layers: [
                  new TileLayerOptions(
                    urlTemplate:
                    "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}