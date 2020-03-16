import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drive_thru/root.dart';
import 'package:drive_thru/src/screens/Carts.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../shared/Product.dart';

class CartManagement{

  addCartItem(context, Order cartmangagemtorder,restid) async{
   
    // {mealName, mealPrice, timeToDone, docID, photoURL}
    final docRef = await Firestore.instance.collection('/users').document(uID).collection('Cart').add({
      'Item Image URL': cartmangagemtorder.imageurl,
      'Meal Name': cartmangagemtorder.mealname,
      'Meal Price': cartmangagemtorder.price,
      'Time To Done' : cartmangagemtorder.timeToDone,
      'Quantity':cartmangagemtorder.itemQuantity
    });
    docRef.documentID;
  
    print('Uploaded');
      Navigator.of(context).pop();
    Navigator.push(context, PageTransition(type: PageTransitionType.leftToRight, child: Carts(uid:uID,resturantID: restid,)));
  
  }





 QuerySnapshot querySnapshot;
  cartreset() async {
    List<DocumentSnapshot> cartItems=[];
    querySnapshot = await Firestore.instance
        .collection('/users')
        .document(uID).collection("Cart").getDocuments();
        
    cartItems.addAll(querySnapshot.documents);
        cartItems.map((value){
      Firestore.instance.collection("/users").document(uID).collection("Cart").document(value.documentID).delete();
     
    }).toList();
  }
}