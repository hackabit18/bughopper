import 'package:feel_safe/pages/createReport.dart';
import 'package:feel_safe/pages/mapview.dart';
import 'package:flutter/material.dart';
import 'package:feel_safe/services/locationinfo.dart';
import 'package:geocoder/geocoder.dart';

class CreateReportOptions extends StatefulWidget {
  @override
  _CreateReportOptionsState createState() => _CreateReportOptionsState();
}

class _CreateReportOptionsState extends State<CreateReportOptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Location")),
      body: Container(
        padding: EdgeInsets.all(80.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              MaterialButton(
                child: Text("Choose Current Location"),
                onPressed: () async {
                  Address address = await getCurrentLocation();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CreateReport(address)));
                },
                color: Colors.blue,
              ),
              Text("OR"),
              MaterialButton(
                child: Text("Choose Location on Map"),
                color: Colors.blue,
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MapView(false)));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
