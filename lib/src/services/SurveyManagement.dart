// import 'package:drive_thru/src/screens/NewDashboard.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:page_transition/page_transition.dart';


class SurveyManagement{
  addNewAnswer({answer1, answer2, answer3, answer4, context}){
    Firestore.instance.collection('/Survey').document('Q1').collection('Answers').add({
      'Answer': answer1,
    });
    Firestore.instance.collection('Survey').document('Q2').collection('Answers').add({
      'Answer': answer2,
    });
    Firestore.instance.collection('Survey').document('Q3').collection('Answers').add({
      'Answer': answer3,
    });
    Firestore.instance.collection('Survey').document('Q4').collection('Answers').add({
      'Answer': answer4,
    }).then((value){
      //Navigator.of(context).pop();
      // Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child: NewDashboard()));
    }).catchError((e){print(e);});

  }
}