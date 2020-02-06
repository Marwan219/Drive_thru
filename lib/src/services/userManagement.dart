import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drive_thru/src/screens/Dashboard.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import '../screens/ResturantList.dart';


class UserManagement{
  storeNewUser(user, fullName, context){
    Firestore.instance.collection('/users').add({
      'Full Name' : fullName,
      'Email' : user.email,
      'uid' : user.uid
    }).then((value){
      //Navigator.of(context).pop();
      Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child: DashBoard()));
    }).catchError((e){print(e);});
  }
}