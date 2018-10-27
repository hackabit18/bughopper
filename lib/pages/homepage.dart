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
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ShowResult(_locationEntered)));
  }

  goToMap() {}

  Widget retButton(text, textColor, color, from) {
    return Padding(
      padding: from == "report now"
          ? EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 110.0)
          : EdgeInsets.all(10.0),
      child: Container(
        height: 50.0,
        child: InkWell(
          onTap: () {
            switch (from) {
              case "report now":
                handleReport();
                break;
              case "go":
                goToResult();
                break;
              case "choose":
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MapView(true)));
                break;
              case "current":
                getCurrentLocation().then((address) {
                  print(address.locality);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ShowResult(address.locality)));
                });

                break;
            }
          },
          child: Material(
            borderRadius: BorderRadius.circular(40.0),
            shadowColor: Colors.greenAccent,
            color: color,
            elevation: 7.0,
            child: Center(
              child: Text(
                "$text",
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FEEL SAFE"),
      ),
      drawer: CustomDrawer(context),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'assets/images/home.jpeg',
            fit: BoxFit.cover,
            colorBlendMode: BlendMode.darken,
          ),
          Container(
            padding: EdgeInsets.all(0.0),
            child: Center(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //Fetching Report options
                  retButton("REPORT NOW", Colors.white, Colors.redAccent,
                      "report now"),

                  Container(
                    child: Text(
                      "FEEL SAFE",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 65.0,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),

                  // Text(
                  //   "Get data",
                  //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  // ),

                  //Enter location
                  // TextField(
                  //   onChanged: (value) => handleLocation(value),
                  //   decoration: InputDecoration(hintText: "Enter Location",),
                  // ),
                  // retButton("GO", Colors.black, Colors.white, "go"),

                  // Text(
                  //   "OR",
                  //   style: TextStyle(fontWeight: FontWeight.bold),
                  // ),

                  //Choose on map
                  retButton(
                      "CHOOSE ON MAP", Colors.black, Colors.white, "choose"),

                  Text(
                    "OR",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  //Current location
                  retButton(
                      "CURRENT LOCATION", Colors.black, Colors.white, "current")
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
