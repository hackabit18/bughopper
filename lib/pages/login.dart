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
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));
    return user;
  }

  Future<FirebaseUser> userData() {
    var user = FirebaseAuth.instance.currentUser();
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset('assets/images/login_back.jpeg', fit: BoxFit.cover,colorBlendMode: BlendMode.darken,),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
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
                      height: 60.0,
                    ),
                    Padding(
                      padding: EdgeInsets.all(50.0),
                      child: Container(
                        height: 50.0,
                        child: InkWell(
                          onTap: () {
                            _signIn();
                          },
                          child: Material(
                            borderRadius: BorderRadius.circular(40.0),
                            shadowColor: Colors.greenAccent,
                            color: Colors.green,
                            elevation: 7.0,
                            child: Center(
                              child: Text(
                                "SIGN IN",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
