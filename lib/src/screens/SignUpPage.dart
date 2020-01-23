import 'dart:core';
import 'package:flutter/material.dart';
import 'package:drive_thru/src/services/userManagement.dart';
import '../shared/styles.dart';
import '../shared/colors.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Dashboard.dart';


class SignUpPage extends StatefulWidget {
  final String pageTitle;

  SignUpPage({Key key, this.pageTitle}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  String _fullName;
  String _email;
  String _password;
  String str = '';
  bool passCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        title: Text('Sign Up',
            style: TextStyle(
                color: Colors.grey, fontFamily: 'Poppins', fontSize: 15)),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              // Navigator.of(context).pushReplacementNamed('/signin');
              Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child: DashBoard()));

            },
            child: Text('Sign In', style: contrastText),
          )
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
        padding: EdgeInsets.only(left: 18, right: 18),
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Welcome to The Virtual DriveThru!', style: h3),
                Text('Let\'s get started', style: taglineText),
                Container(
                  margin: EdgeInsets.only(top: 13),
                  child: TextField(
                    onChanged: (value){
                      _fullName = value;
                    },
                    cursorColor: primaryColor,
                    style: inputFieldTextStyle,
                    decoration: InputDecoration(
                        hintText: 'First Name & Last Name',
                        hintStyle: inputFieldHintTextStyle,
                        focusedBorder: inputFieldFocusedBorderStyle,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        border: inputFieldDefaultBorderStyle),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 13),
                  child: TextField(
                    onChanged: (value){
                      setState(() {
                        _email = value;
                      });
                    },
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: primaryColor,
                    style: inputFieldTextStyle,
                    decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: inputFieldHintTextStyle,
                        focusedBorder: inputFieldFocusedBorderStyle,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        border: inputFieldDefaultBorderStyle),
                  ),
                ),
                Container(
                margin: EdgeInsets.only(top: 13),
                child: TextField(
                  onChanged: (value){
                    setState(() {
                      if (value.length<6){str = 'Password need to be at least 6 characters'; passCheck = false;}
                      else{str = ''; passCheck = true;}
                    });
                    print(str); 
                  },
                  onSubmitted: (value){
                    setState(() {
                      _password = value;
                    });
                  },
                  obscureText: true,
                  cursorColor: primaryColor,
                  style: inputFieldHintPaswordTextStyle,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: inputFieldHintPaswordTextStyle,
                      focusedBorder: inputFieldFocusedBorderStyle,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      border: inputFieldDefaultBorderStyle),
                ),
              ),
              Text(str, style: TextStyle(color: Colors.red),),
              ],
            ),
            Positioned(
              bottom: 15,
              right: -15,
              child: FlatButton(
                onPressed: () {
                  if(passCheck == true){
                    FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: _email ,
                      password: _password
                    ).then((signedInUser) {UserManagement().storeNewUser(signedInUser.user, _fullName, context);}).catchError((e){print(e);});
                  }
                },
                color: primaryColor,
                padding: EdgeInsets.all(13),
                shape: CircleBorder(),
                child: Icon(Icons.arrow_forward, color: white),
              ),
            )
          ],
        ),
        height: 360,
        
        width: double.infinity,
        decoration: authPlateDecoration,
      ),
        ],
      )
    );
  }
}