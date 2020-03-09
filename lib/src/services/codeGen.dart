import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';


class CodeGenerator{
  int count = 0;
  Map<int, int> map = {5: 20, 10: 50, 15: 100};
  List<int> codes = [];

  List<int> codeGen(int num, List<int> list) {
    var rnd = new Random();
    for (int i = 0; i < num; i++) {
      var next = rnd.nextDouble() * 10000000000;
      while (next < 10000000000) {
        next *= 10;
      }
      //print(next.toInt());
      list.add(next.toInt());
    }
    return list;
  }

  void dataEntry(int key, int value, List<int> list) async {
    int i = 0;
    while (i < key) {
      await Firestore.instance.collection('Cards').document(list[0].toString()).setData({
        'value' : value,
        'code':list[0],
        'Time created': 0000,
        'validation':true
      }).catchError((onError){
        print(e);
      });
      print('$value, ' + list[0].toString());
      list.removeAt(0);
      i += 1;
    }
  }

  void result(){
    map.forEach((k, v) => count += k);
    codeGen(count, codes);
    map.forEach((k, v) => dataEntry(k, v, codes));
  }

}