import 'package:drive_thru/root.dart';
import 'package:flutter/material.dart';
import './src/screens/SignInPage.dart';
import './src/screens/SignUpPage.dart';
import './src/screens/ResturantList.dart';
import './src/screens/ProductPage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './generated/intl/l10n.dart';
import './generated/intl/helper.dart';
import './src/services/flutter_restart.dart';
// void main() => runApp(MyApp());
 void main() {
  runApp(
    RestartWidget(
      child: MyApp(),
    ),
  );
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}
class _MyAppState extends State<MyApp> {
    SpecificLocalizationDelegate specificLocalizationDelegate; 
  void initState() {
    // TODO: implement initState
    super.initState();
   helper.onLocaleChanged = onLocaleChange;  

      specificLocalizationDelegate =  SpecificLocalizationDelegate(new Locale(language));
  }

  onLocaleChange(Locale locale){
    setState((){
     
      specificLocalizationDelegate = new SpecificLocalizationDelegate(locale);
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Virtual DriveThru',
      localizationsDelegates: [
       specificLocalizationDelegate,
       GlobalMaterialLocalizations.delegate,
       GlobalWidgetsLocalizations.delegate,],
      locale: specificLocalizationDelegate.overriddenLocale,
      supportedLocales:specificLocalizationDelegate.supportedLocales,
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
