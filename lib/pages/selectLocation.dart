import 'package:flutter/material.dart';

class SelectLocation extends StatefulWidget {
  @override
  _SelectLocationState createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
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
                onPressed: null,
                color: Colors.blue,
              ),
              Text("OR"),
              MaterialButton(
                child: Text("Choose Location on Map"),
                color: Colors.blue,
                onPressed: null,
              )
            ],
          ),
        ),
      ),
    );
  }
}
