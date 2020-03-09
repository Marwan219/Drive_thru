import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drive_thru/src/screens/survey.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';


class UserManagement{
  storeNewUser(user, fullName, context){
    Firestore.instance.collection('/users').document(user.uid).setData({
      'Full Name' : fullName,
      'Email' : user.email,
      'uid' : user.uid
    }).then((value){
      Navigator.of(context).pop();
      Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child: Survey()));
    }).catchError((e){print(e);});
  }
}