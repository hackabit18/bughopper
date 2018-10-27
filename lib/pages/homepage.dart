import 'package:feel_safe/pages/createReportOptions.dart';
import 'package:feel_safe/pages/mapview.dart';
import 'package:feel_safe/pages/result.dart';
import 'package:feel_safe/services/locationinfo.dart';
import 'package:feel_safe/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _locationEntered = "";

  handleReport() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => CreateReportOptions()));
  }

  handleLocation(val) {
    _locationEntered = val;
  }

  goToResult() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ShowResult(_locationEntered)));
  }

  goToMap() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FEEL SAFE"),
      ),
      drawer: CustomDrawer(context),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              //Submit report option
              MaterialButton(
                child: Text("Report Now"),
                onPressed: handleReport,
                color: Colors.blue,
              ),

              //Fetching Report options
              Text("Get data"),

              //Enter location

              TextField(
                onChanged: (value) => handleLocation(value),
                decoration: InputDecoration(hintText: "Enter Location"),
              ),
              MaterialButton(
                child: Text("GO"),
                onPressed: goToResult,
                color: Colors.blue,
              ),

              Text("OR"),

              //Choose on map
              MaterialButton(
                child: Text("Choose on Map"),
                color: Colors.blue,
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => MapView(true)));
                },
              ),

              Text("OR"),

              //Current location
              MaterialButton(
                onPressed: () async {
                  Address address = await getCurrentLocation();
                  print(address.locality);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ShowResult(address.locality)));
                },
                child: Text("Current Location"),
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
