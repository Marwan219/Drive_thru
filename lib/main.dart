import 'package:drive_thru/root.dart';
import 'package:flutter/material.dart';
import './src/screens/SignInPage.dart';
import './src/screens/SignUpPage.dart';
import './src/screens/HomePage.dart';
import './src/screens/ResturantList.dart';
import './src/screens/ProductPage.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Virtual DriveThru',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Root(),
      routes: <String, WidgetBuilder> {
        '/signup': (BuildContext context) =>  SignUpPage(),
        '/signin': (BuildContext context) =>  SignInPage(),
        '/resturantlist': (BuildContext context) => ResturantList(),
        '/productPage': (BuildContext context) => ProductPage(),
      },
    );
  }
}
