import 'dart:math';

import 'package:drive_thru/src/screens/wallet.dart';
import 'package:drive_thru/src/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drive_thru/root.dart';

class Charge {
  int codeValue = 0;
  bool codevalidation = false;
  chargeaccount({code, balance, context}) {
    AlertDialog emptyalert = AlertDialog(
      title: Text("Sorry "),
      content: Text("Code is incorrrct! or charged before "),
      actions: [
        FlatButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    AlertDialog alert = AlertDialog(
      title: Text("Done"),
      content: Text("your wallet has been charged "),
      actions: [
        FlatButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    DocumentReference documentReference =
        Firestore.instance.collection("Cards").document(code.toString());
    documentReference.get().then((snapshot) {
      codevalidation = snapshot.data['validation'];
      if (codevalidation == true) {
        codeValue = snapshot.data['value'];
        Firestore.instance.collection('users').document(uID).updateData({
          'wallet': codeValue + balance,
        }).then((snap) {
          Firestore.instance
              .collection('Cards')
              .document(code.toString())
              .updateData({
            'validation': false,
          });
        });

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      } else {
        throw (e);
      }
    }).catchError((e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return emptyalert;
        },
      );
      print('Code is incorrrct! or charged before');
    });
  }
}
