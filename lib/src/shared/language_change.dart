// import 'package:flutter/widgets.dart';
// import '../../generated/intl/l10n.dart';
// import '../../generated/intl/helper.dart';
// import 'package:flutter/material.dart';
// import '../services/flutter_restart.dart';

 
//   neverSatisfied(context,Key key) {
//   return showDialog(
//     context: context,
//     barrierDismissible: false, // user must tap button!
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title:Center(child:Text(AppLocalizations.of(context).language),) ,
//         // elevation: 40.0,
      
//         actions: <Widget>[
//           Column(
//             children: <Widget>[
//              Container(
//                width:MediaQuery.of(context).size.width   ,
//                child:OutlineButton(
//               shape: new Border.all(width: 2,color: Colors.black),
//               child: new Text("English"), onPressed: (){
//                   this.setState((){
//                    helper.onLocaleChanged(new Locale("en"));
//                     language = "en";
//                    RestartWidget.of(context).restartApp();
//                   });}),),
                 
//                      Divider(
//                               color: Colors.black,
//                             ),
//                Container(
//                  width:MediaQuery.of(context).size.width,
//                  child: OutlineButton(
//                 shape: new Border.all(width: 2,color: Colors.black),
//               child: new Text("عربى"), onPressed: (){
//                   this.setState((){
//                    helper.onLocaleChanged(new Locale("ar"));
//                     language = "ar";
//                    RestartWidget.of(context).restartApp();
//                   });}),),
              
//                   Divider(),
              
//             RaisedButton(
//                 child: Text(
//                   "Cancel",
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 onPressed: () => Navigator.pop(context),
//               ),
//             ],
//           )

//         ],
//       );
//     },
//   );
// }