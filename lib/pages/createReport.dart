import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateReport extends StatefulWidget {
  @override
  _CreateReportState createState() => _CreateReportState();
}

class _CreateReportState extends State<CreateReport> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Report"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Title"
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Information"
                    ),
                  ),
                  MaterialButton(
                    child: Text("Submit"),
                    onPressed: null,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
