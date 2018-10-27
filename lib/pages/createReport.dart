import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoder/geocoder.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseUser mCurrentUser;
FirebaseAuth _auth;

class CreateReport extends StatefulWidget {
  final Address _location;
  CreateReport(this._location);
  @override
  _CreateReportState createState() => _CreateReportState();
}

class _CreateReportState extends State<CreateReport> {
  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    // _getCurrentUser();
  }

  Future<String> getCurrentUser() async {
    mCurrentUser = await _auth.currentUser();
    String currUser = mCurrentUser.displayName.toString();
    print(currUser);
    return (currUser);
  }

  final CollectionReference collectionReference =
      Firestore.instance.collection('reports');

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  String _title = "";
  String _info = "";

  void _showSubmitDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Report successfully submitted"),
          content: new Text("Thank you for contributing"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  submitReport() async {
    var temp = await getCurrentUser();
    // print(temp);
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      if (_title.length > 0 && _info.length > 0) {
        var x={
          'title': _title,
          'information': _info,
          'location': widget._location.addressLine,
          'locality': widget._location.locality,
          'reporter': temp,
        };
        print(x);
        await collectionReference.add(x).catchError((err) {
          print("Error $err");
        });
        _showSubmitDialog();
        // Navigator.pop(context);
      } else {
        print("Error");
        showError("Enter Proper Report Data");
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
                  Text(
                    "Location Selected:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("${widget._location.addressLine}"),
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
