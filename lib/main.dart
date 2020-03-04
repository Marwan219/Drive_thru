import 'package:drive_thru/root.dart';
import 'package:drive_thru/src/screens/NewDashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './src/screens/SignInPage.dart';
import './src/screens/SignUpPage.dart';
import './src/screens/ProductPage.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((_) {
      runApp(new MyApp());
    });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timpo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Root(),
      routes: <String, WidgetBuilder> {
        '/signup': (BuildContext context) =>  SignUpPage(),
        '/signin': (BuildContext context) =>  SignInPage(),
        '/dashboard': (BuildContext context) => NewDashboard(),
        '/productPage': (BuildContext context) => ProductPage(),
      },
    );
  }
}
