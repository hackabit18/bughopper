import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateReport extends StatefulWidget {
  @override
  _CreateReportState createState() => _CreateReportState();
}

class _CreateReportState extends State<CreateReport> {
  final CollectionReference collectionReference =
      Firestore.instance.collection('reports');

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  String _title = "";
  String _info = "";
  String _location = "GS Road";

  submitReport() async {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      if (_title.length > 0 && _info.length > 0) {
        await collectionReference.add({
          'title': _title,
          'information': _info,
          'location': _location
        }).catchError((err) {
          print("Error $err");
        });
        Navigator.pop(context);
      } else {
        print("Error");
        showError("Enter Proper Event Data");
      }
    }
  }

  //Show a snackbar at the bottom
  showError(String error) {
    final snackbar = SnackBar(
      content: new Text(error),
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Create Report"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(35.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Title",
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.redAccent),
                      ),
                    ),
                    onSaved: (value) => _title = value,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: "Information",
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.redAccent),
                      ),
                    ),
                    onSaved: (value) => _info = value,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text("Location Selected:"),
                  SizedBox(
                    height: 40.0,
                  ),
                  MaterialButton(
                    child: Text("Submit Report"),
                    textColor: Colors.white,
                    color: Colors.red,
                    onPressed: submitReport,
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
