import 'package:drive_thru/src/screens/Menu.dart';
import 'package:drive_thru/src/shared/Loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../shared/styles.dart';
import '../shared/colors.dart';
import 'package:page_transition/page_transition.dart';
import './SignUpPage.dart';

class SignInPage extends StatefulWidget {
  final String pageTitle;

  SignInPage({Key key, this.pageTitle}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool loading = false;
  String _email;
  String _password;
  
  Widget okButton = FlatButton(
  child: Text("OK"),
  onPressed: () { },
  );

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        title: Text('Sign In',
            style: TextStyle(
                color: Colors.grey, fontFamily: 'Poppins', fontSize: 15)),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              // Navigator.of(context).pushReplacementNamed('/signup');
              Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft,  child: SignUpPage()));

            },
            child: Text('Sign Up', style: contrastText),
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
                Text('Welcome Back!', style: h3),
                Text('Howdy, let\'s authenticate', style: taglineText),
                Container(
                  margin: EdgeInsets.only(top: 13),
                  child: TextField(
                    onChanged: (value){
                      _email = value;
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
                      _password = value;
                    },
                    onSubmitted: (value){
                      _password = value;
                      setState( () {loading = true;});
                      FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: _email,
                        password: _password
                      ).then((user){
                       Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child: Menu()));
                      }).catchError((e) {
                        setState((){
                          loading = false;
                        });
                        print(e);
                        // AlertDialog alert = AlertDialog(
                        //   title: Text("ERROR"),
                        //   content: Text("$e"),
                        //   actions: [
                        //     okButton,
                        //   ],
                        // );
                      
                        // showDialog(
                        //   context: context,
                        //   builder: (BuildContext context) {
                        //     return alert;
                        //   },
                        // );
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
                FlatButton(
                  onPressed: () {},
                  child: Text('Forgot Password?', style: contrastTextBold),
                )
              ],
            ),
            Positioned(
              bottom: 15,
              right: -15,
              child: FlatButton(
                onPressed: () {
                    setState( () {loading = true;});
                    FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: _email,
                      password: _password
                    ).then((user){
                      Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child: Menu()));
                    }).catchError((e) {
                      setState((){
                        loading = false;
                      });
                      print(e);
                      AlertDialog alert = AlertDialog(
                        title: Text("ERROR"),
                        content: Text("$e"),
                        actions: [
                          okButton,
                        ],
                      );
                      
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );

                    });
                },
                color: primaryColor,
                padding: EdgeInsets.all(13),
               shape: CircleBorder(),
                child: Icon(Icons.arrow_forward, color: white),
              ),
            )
          ],
        ),
        height: 245,
        
        width: double.infinity,
        decoration: authPlateDecoration,
      ),
        ],
      )
    );
  }
}