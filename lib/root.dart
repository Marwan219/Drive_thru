import 'package:drive_thru/src/screens/Dashboard.dart';
import 'package:drive_thru/src/screens/HomePage.dart';
import 'package:drive_thru/src/services/AuthService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Root extends StatefulWidget {
  //Root({this.current});
  //final AuthService current;
  @override
  _RootState createState() => _RootState();
}

enum AuthStatus{
  notSignedIn,
  signedIn,
}

class _RootState extends State<Root> {

  AuthStatus authStatus = AuthStatus.notSignedIn;

  initState(){
    super.initState();
    FirebaseAuth.instance.currentUser().then((user){
      setState((){
        authStatus = user == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus){
      case AuthStatus.signedIn:
        return DashBoard();
      case AuthStatus.notSignedIn:
        // TODO: Handle this case.
        return HomePage(pageTitle: 'Welcome');
    }
  }
}