import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drive_thru/src/screens/Dashboard.dart';
import 'package:drive_thru/src/screens/Image_picker.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ResturantManagement{


  addNewResturant(context, restMap) async{
    final docRef = await Firestore.instance.collection('/Restaurants').add({
      'Resturant Info': restMap
    });
    docRef.documentID;
    
    print('Uploaded');
      //Navigator.of(context).pop();
      
 
    Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.leftToRight, child: Image_picker(docRef.documentID)));
  
  }
}