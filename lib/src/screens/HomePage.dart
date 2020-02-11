import 'package:drive_thru/src/screens/Dashboard.dart';
import 'package:drive_thru/src/screens/menu.dart';
import 'package:flutter/material.dart';
import '../shared/styles.dart';
import '../shared/colors.dart';
import '../shared/buttons.dart';
import '../../generated/intl/l10n.dart';
import '../../generated/intl/helper.dart';
import '../services/flutter_restart.dart';
import 'package:page_transition/page_transition.dart';
import './SignUpPage.dart';
import './SignInPage.dart';

class HomePage extends StatefulWidget {
  final String pageTitle;

  HomePage({Key key, this.pageTitle}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

   Future<void> neverSatisfied() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title:Center(child:Text(AppLocalizations.of(context).language),) ,
        // elevation: 40.0,
      
        actions: <Widget>[
          Column(
            children: <Widget>[
             Container(
               width:MediaQuery.of(context).size.width   ,
               child:OutlineButton(
              shape: new Border.all(width: 2,color: Colors.black),
              child: new Text("English"), onPressed: (){
                  this.setState((){
                   helper.onLocaleChanged(new Locale("en"));
                    language = "en";
                   RestartWidget.of(context).restartApp();
                  });}),),
                 
                     Divider(
                              color: Colors.black,
                            ),
               Container(
                 width:MediaQuery.of(context).size.width,
                 child: OutlineButton(
                shape: new Border.all(width: 2,color: Colors.black),
              child: new Text("عربى"), onPressed: (){
                  this.setState((){
                   helper.onLocaleChanged(new Locale("ar"));
                    language = "ar";
                   RestartWidget.of(context).restartApp();
                  });}),),
              
                  Divider(),
              
            RaisedButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          )

        ],
      );
    },
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset('images/welcome.png', width: MediaQuery.of(context).size.width * 0.35, height: MediaQuery.of(context).size.height * 0.35 ),
          Container(
            margin: EdgeInsets.only(bottom: 10, top: 0),
            child: Text('Virtual Drive-Thru!', style: logoStyle),
          ),
          Container(
            width: 200,
            margin: EdgeInsets.only(bottom: 0),
            child: froyoFlatBtn(AppLocalizations.of(context).signIn, (){ 

              Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rotate, duration: Duration(seconds: 1),  child: DashBoard()
              
              ));
            }),
          ),
          Container(
            width: 200,
            padding: EdgeInsets.all(0),
            child: froyoOutlineBtn(AppLocalizations.of(context).signUp, (){
              Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rotate, duration: Duration(seconds: 1),  child: SignUpPage()));
              // Navigator.of(context).pushReplacementNamed('/signup');
             }),
          ),
          Container(
            margin: EdgeInsets.only(top: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: <Widget>[
               FlatButton(
              child: Text(AppLocalizations.of(context).language),
              onPressed:(){
                neverSatisfied();
              } ,)
              ],
            ),
          )
        ],
      )),
      backgroundColor: bgColor,
    );
  }
}
