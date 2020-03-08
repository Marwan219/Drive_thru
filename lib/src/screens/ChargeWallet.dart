import 'package:drive_thru/src/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drive_thru/root.dart';


class Charge extends StatelessWidget {
  int code;
  int codeValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Charge Your Wallet'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          TextField(
            onChanged: (value){
              code = int.parse(value);
            },
          ),
          RaisedButton(
            onPressed:(){
              DocumentReference documentReference =
                Firestore.instance.collection("Cards").document(code.toString());
              documentReference.get().then((snapshot){
                codeValue = snapshot.data['value'];
                Firestore.instance.collection('users').document(uID).updateData(
                  {'wallet':codeValue}
                );
                print(codeValue);
              }).catchError((e){
                print('Code is incorrrct!');
              });
            } 
          ),
        ],
      ),
      
    );
  }
}