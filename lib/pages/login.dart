import 'package:feel_safe/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignin = GoogleSignIn();

  Future<FirebaseUser> _signIn() async {
    GoogleSignInAccount googleSignInAccount = await googleSignin.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    FirebaseUser user = await _auth.signInWithGoogle(
        idToken: gSA.idToken, accessToken: gSA.accessToken);

    print("User Name : ${user.displayName}");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));
    return user;
  }

  _signOut() async{
    await googleSignin.signOut();
    await googleSignin.disconnect();
    Navigator.pop(context);
    var user = await FirebaseAuth.instance.currentUser();
    print("User Signed out $user");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            RaisedButton(
              child: Text("Sign In"),
              onPressed: () => _signIn(),
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            RaisedButton(
              child: Text("Sign Out"),
              onPressed: () async {
                try {
                  await _signOut();
                } catch (e) {
                  print(e);
                }
              },
            ),
            Padding(padding: EdgeInsets.all(10.0))
          ],
        ),
      ),
    );
  }
}
