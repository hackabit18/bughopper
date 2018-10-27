import 'dart:convert';
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
  String key, query, url;
  List data = [];
  int length;

  @override
  void initState() {
    super.initState();
    key = "3ec0174b543a4af7a29f7437dc687ead";
    query =
        "(+injured OR +killed OR +accident) AND (+${widget._location}) AND (-football OR -cricket OR -) AND ${widget._location}";
    url = "https://newsapi.org/v2/everything?q=$query&apiKey=$key";
    print(url);
    this.getJsonData();
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

    return "Sucess";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("News")),
        drawer: CustomDrawer(context),
        body: ListView.builder(
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
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}
