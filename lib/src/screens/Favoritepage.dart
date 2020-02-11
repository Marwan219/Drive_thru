import 'package:flutter/material.dart';
import 'package:drive_thru/src/screens/AddResturant.dart';
import 'package:drive_thru/src/screens/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Dashboard.dart';
import 'package:drive_thru/src/screens/HomePage.dart';
import 'package:drive_thru/src/screens/Timerpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../shared/styles.dart';
import '../shared/colors.dart';
import '../shared/fryo_icons.dart';
import './Menu.dart';
import '../shared/Product.dart';
import '../shared/partials.dart';
import './OldDashboard.dart';

//void main() => runApp(MaterialApp(

/*Widget build(BuildContext context) {
  ThemeData themeData = Theme.of(context);
  return Scaffold(
    backgroundColor: bgColor,
    appBar: AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: primaryColor,
      title: Text('Virtual DriveThru',
          style: logoWhiteStyle, textAlign: TextAlign.center),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                PageTransition(
                    type: PageTransitionType.leftToRightWithFade,
                    child: DashBoard()));
          },
          color: primaryColor,
          padding: EdgeInsets.all(2),
          shape: CircleBorder(),
          child: Icon(
            Icons.home,
            color: white,
            size: 25,
          ),
        ),
      ],
    ),
    drawer: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Virtual Drive Thru',
              style: logoWhiteStyle,
              textAlign: TextAlign.center,
            ),
            decoration: BoxDecoration(
              color: Colors.orange,
            ),
          ),
          ListTile(
            title: Text('Home Page'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      type: PageTransitionType.leftToRightWithFade,
                      child: DashBoard()));
            },
          ),
          ListTile(
            title: Text('My Profile'),
            onTap: () {},
          ),
          ListTile(
            title: Text('My Cart'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Add Restaurant'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      type: PageTransitionType.leftToRightWithFade,
                      child: AddResturant()));
            },
          ),
          ListTile(
            title: Text('Settings'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Timer Page'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      type: PageTransitionType.leftToRightWithFade,
                      child: TimerPage()));
            },
          ),
          ListTile(
            title: Text('Sign Out'),
            onTap: () {
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        type: PageTransitionType.leftToRightWithFade,
                        child: HomePage()));
              }).catchError((e) {
                print(e);
              });
            },
          ),
        ],
      ),
    ),
  );
}*/

class Favoritepage extends StatefulWidget {
  @override
  FavoritepageState createState() => FavoritepageState();
}

class FavoritepageState extends State {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: BackButton(
            color: darkText,
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return new DashBoard();
              }));
            },
          ),
          title: Text('Favorite'), // the text on the bar
          centerTitle: true,
          backgroundColor: Colors.orange,
        ),
        body: new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
           
          
          RaisedButton(
            color: Colors.orange,
            child: Text('Favorite food'),
            onPressed: null,
          ),
          RaisedButton(
            color: Colors.orange,
            child: Text('favorite resturants'),
            onPressed: null,
          ),
        ]),
      ),
     ),);
      
  }
}
/*
class Favoritepage extends StatefulWidget {
  @override
  _Favoritepage createState() => _Favoritepage();
}

class _Favoritepage extends State<Favoritepage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}*/
