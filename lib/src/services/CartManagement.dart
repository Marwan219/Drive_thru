import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:drive_thru/src/screens/Carts.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class CartManagement{
  // final String resturantID;
  // MenuManagement(this.resturantID);

  addCartItem(context, {mealName, mealPrice, timeToDone, docID, photoURL}) async{
    final docRef = await Firestore.instance.collection('/users').document(docID).collection('Cart').add({
      'Item Image URL': photoURL,
      'Meal Name': mealName,
      'Meal Price': mealPrice,
      'Time To Done' : timeToDone,
    });
    docRef.documentID;
    
    print('Uploaded');
      //Navigator.of(context).pop();
      
 
    // Navigator.push(context, PageTransition(type: PageTransitionType.leftToRight, child: Carts(uid:docID)));
  
  }
}