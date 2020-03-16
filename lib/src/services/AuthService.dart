import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

import 'package:flutter/cupertino.dart';

class AuthService with ChangeNotifier{
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<FirebaseUser> getUser(){
    return _auth.currentUser();
  }

  Future<AuthResult> signinUser({String email, String password})async{
    try{
      var result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password
    );
    
    notifyListeners();
    return result;
    } catch(e){
      print(e);
    }
  }

  idOfUser() async{
    FirebaseUser user = await AuthService().getUser();
    var id = user.uid;
    return id;
  }

  Future signOutUser() async{
    var result = await _auth.signOut();
    notifyListeners();
    return result;
  }

}