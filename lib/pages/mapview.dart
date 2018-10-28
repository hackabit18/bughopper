import 'package:feel_safe/pages/createReport.dart';
import 'package:feel_safe/pages/result.dart';
import 'package:feel_safe/services/locationinfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoder/geocoder.dart';
import 'package:latlong/latlong.dart';

class MapView extends StatefulWidget {
  //true results page
  //false create page
  bool resultsPage;
  MapView(this.resultsPage);
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  List<LatLng> tappedPoints = [];

  Widget build(BuildContext context) {
    var markers = tappedPoints.map((latlng) {
      return new Marker(
        width: 80.0,
        height: 80.0,
        point: latlng,
        builder: (ctx) => new Container(
              child: Icon(
                Icons.location_on,
              ),
            ),
      );
    }).toList();

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Tap to add pins"),
        actions: <Widget>[
          MaterialButton(
            color: Colors.white,
            child: Text("OK", style: TextStyle(fontSize: 20.0, fontFamily: "Montserrat",fontWeight: FontWeight.bold),),
            onPressed: () async {
              print(tappedPoints[0]);

              final coordinates = new Coordinates(
                  tappedPoints[0].latitude, tappedPoints[0].longitude);
              var addresses = await Geocoder.local
                  .findAddressesFromCoordinates(coordinates);
              var first = addresses.first;
              if (widget.resultsPage) {
                //go to results page
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ShowResult(first.locality)));
              } else {
                // go to success pages
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CreateReport(first)));
              }
            },
          ),
        ],
      ),
      body: new Padding(
        padding: new EdgeInsets.all(8.0),
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
                    onTap: _handleTap),
                layers: [
                  new TileLayerOptions(
                    urlTemplate:
                        "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  ),
                  new MarkerLayerOptions(markers: markers)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleTap(LatLng latlng) {
    setState(() {
      try {
        tappedPoints.removeAt(0);
      } catch (e) {
        print("empty");
      }
      print(
          "Latitude : ${latlng.latitude} and Longitude : ${latlng.longitude}");
      tappedPoints.add(latlng);
    });
  }
}
