import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:drive_thru/src/screens/Image_picker.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ResturantManagement{


  addNewResturant(context, {firstName, lastName, restname, latitude, longitude, gmNum, gmName, branNum, gmMail, hqLocation, hotLine, restNum, restNum2, newsletter}) async{
    final docRef = await Firestore.instance.collection('/Restaurants').add({
      'Resturant Name': restname,
      'Resturant Number' : restNum,
      'Resturant latitude' : latitude,
      'Resturant longitude' : longitude,
      'GM Number' : gmNum,
      'GM Name' : gmName,
      'Number Of Branches' : branNum,
      'GM E-Mail' : gmMail,
      'HQ Location' : hqLocation, 
      'HotLine' : hotLine,  
      'Resturant Number 2' : restNum2,
      'News Letter' : newsletter,

    });
    docRef.documentID;
    
    print('Uploaded');
      //Navigator.of(context).pop();
      
 
    // Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.leftToRight, child: Image_picker(docRef.documentID)));
  
  }
}