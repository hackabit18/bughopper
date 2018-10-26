import 'package:feel_safe/widgets/drawer.dart';
import 'package:flutter/material.dart';

class CreateReportOptions extends StatefulWidget {
  @override
  _CreateReportOptionsState createState() => _CreateReportOptionsState();
}

class _CreateReportOptionsState extends State<CreateReportOptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Location")),
      drawer: CustomDrawer(context),
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
