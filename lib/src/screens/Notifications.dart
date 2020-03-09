import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drive_thru/src/screens/Buy.dart';
import 'package:drive_thru/src/screens/Orders.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../shared/styles.dart';
import '../shared/colors.dart';
import 'ProductPage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'menu.dart';

class Notifications extends StatefulWidget{
  
  @override

  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications>{
  var list = [1,2,3];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),

      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child:ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index){
                  return ListTile( 
                    title:Text("OFFERS"),
                    subtitle: Text("Details Of Offers"),
                    trailing: Image(image:NetworkImage("https://images.unsplash.com/photo-1512106374988-c95f566d39ef?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=80")),
                  );
              },
            )
          )
        ],
      ),
    )
    

    ;
    }

       

 
  //  Widget myDetailsContainer1() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //     children: <Widget>[
  //       Padding(
  //         padding: const EdgeInsets.only(left: 8.0),
  //         child: Container(child: Text("Offers",
  //           style: TextStyle(color: Color(0xffe6020a), fontSize: 24.0,fontWeight: FontWeight.bold),)),
  //       ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 8.0),
        //   child: Container(
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //         children: <Widget>[
        //           Container(child: Text("4.3",
        //             style: TextStyle(color: Colors.black54, fontSize: 18.0,),)),
        //           Container(child: Icon(
        //             FontAwesomeIcons.solidStar, color: Colors.amber,
        //             size: 15.0,),),
        //           Container(child: Icon(
        //             FontAwesomeIcons.solidStar, color: Colors.amber,
        //             size: 15.0,),),
        //           Container(child: Icon(
        //             FontAwesomeIcons.solidStar, color: Colors.amber,
        //             size: 15.0,),),
        //           Container(child: Icon(
        //             FontAwesomeIcons.solidStar, color: Colors.amber,
        //             size: 15.0,),),
        //           Container(child: Icon(
        //             FontAwesomeIcons.solidStarHalf, color: Colors.amber,
        //             size: 15.0,),),
        //           Container(child: Text("(321) \u00B7 0.9 mi",
        //             style: TextStyle(color: Colors.black54, fontSize: 18.0,),)),
        //         ],)),
        // ),
  //       Container(child: Text("Discount",
  //         style: TextStyle(color: Colors.black54, fontSize: 18.0,fontWeight: FontWeight.bold),)),
  //     ],
  //   );
  // }
  // Widget build(BuildContext context) {
    // TODO: implement build
  //   return Scaffold(
  //     resizeToAvoidBottomPadding: false,
  //     backgroundColor: bgColor,
  //       appBar: new AppBar(
  //         centerTitle: true,
  //         elevation: 0,
  //         backgroundColor: primaryColor,
  //         title:
  //             Text('Notifications', style: logoWhiteStyle, textAlign: TextAlign.center),
              
  //       ),
  //       body: ListView(
  //       scrollDirection: Axis.vertical,
  //       children: <Widget>[
  //         Padding(
  //           padding: const EdgeInsets.all(16.0),
  //           child: Container(
  //             child: new FittedBox(
  //               child: Material(
  //                   color: Colors.white,
  //                   elevation: 14.0,
  //                   borderRadius: BorderRadius.circular(24.0),
  //                   shadowColor: Color(0x802196F3),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: <Widget>[
  //                       Container(
  //                         child: Padding(
  //                           padding: const EdgeInsets.only(left: 16.0),
  //                           child: myDetailsContainer1(),
  //                         ),
  //                       ),

  //                       Container(
  //                         width: 250,
  //                         height: 100,
  //                         child: ClipRRect(
  //                           borderRadius: new BorderRadius.circular(24.0),
  //                           child: Image(
  //                             fit: BoxFit.contain,
  //                             alignment: Alignment.topRight,
  //                             image: NetworkImage(
  //                                 "https://images.unsplash.com/photo-1512106374988-c95f566d39ef?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=80"),
  //                           ),
  //                         ),),
  //                     ],)
  //               ),
  //             ),
  //           ),
  //         ),


  //        ] ),
         
  //   );
    
}