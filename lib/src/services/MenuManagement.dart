import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drive_thru/src/screens/NewDashboard.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class MenuManagement{
  final String resturantID;
  MenuManagement(this.resturantID);

  addMenuItem(context, {mealName, mealPrice, timeToDone, newsletter, docID}) async{
    final docRef = await Firestore.instance.collection('/Restaurants').document(docID).collection('Menu').add({
      'Meal Name': mealName,
      'Meal Price': mealPrice,
      'Time To Done' : timeToDone,
      'News Letter' : newsletter
    });
    docRef.documentID;
    
    print('Uploaded');
      //Navigator.of(context).pop();
      
 
    Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.leftToRight, child: NewDashboard()));
  
  }
}