import 'package:drive_thru/src/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drive_thru/root.dart';

class Charge {
  int codeValue;

  chargeaccount(code, balance)  {

    DocumentReference documentReference =
        Firestore.instance.collection("Cards").document(code.toString());
    documentReference.get().then((snapshot) {
      codeValue = snapshot.data['value'];
      Firestore.instance
          .collection('users')
          .document(uID)
          .updateData({'wallet': codeValue + balance});
      print(codeValue);
    }).catchError((e) {
      print(e);
      print('Code is incorrrct!');
    });
  }
}
