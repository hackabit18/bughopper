import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feel_safe/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ShowResult extends StatefulWidget {
  final String _location;
  ShowResult(this._location);
  @override
  _ShowResultState createState() => _ShowResultState();
}

class _ShowResultState extends State<ShowResult> {
  StreamSubscription<QuerySnapshot> subscription;
  bool t = true;

  List<DocumentSnapshot> eventsData;
  int _lengthOfEventsData = 0;

  final CollectionReference collectionReference =
      Firestore.instance.collection('reports');
  String key, query, url, myText;
  List data = [];
  int length;

  @override
  void initState() {
    super.initState();
    key = "c0dd7cc7ac9d4795a2899b239ca25dd8";
    query =
        "(+injured OR +killed OR +accident) AND (+${widget._location}) AND (-football OR -cricket) AND ${widget._location}";
    url = "https://newsapi.org/v2/everything?q=$query&apiKey=$key";
    print(url);
    this.getJsonData();

    subscription = collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        eventsData = datasnapshot.documents;
        _lengthOfEventsData = eventsData.length;
        print("len $_lengthOfEventsData");
      });
    });
  }

  Future<String> getJsonData() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    // print(response.body);

    setState(() {
      var convertDataDataToJson = json.decode(response.body);
      data = convertDataDataToJson['articles'];
      // print(data);
    });

    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
        actions: <Widget>[
          MaterialButton(
            child: Text("t"),
            onPressed: () {
              setState(() {
                t = !t;
              });
            },
          )
        ],
      ),
      drawer: CustomDrawer(context),
      body: t
          ? ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(data[index]['title']),
                        Padding(
                          padding: EdgeInsets.all(1.0),
                        ),
                        Text(data[index]['url']),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : ListView.builder(
            itemCount: _lengthOfEventsData,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(eventsData[index].data['title']),
                      Padding(
                        padding: EdgeInsets.all(1.0),
                      ),
                      Text(eventsData[index].data['information']),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }
}
