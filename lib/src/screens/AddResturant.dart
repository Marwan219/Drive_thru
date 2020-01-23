import 'package:drive_thru/src/screens/ResturantList.dart';
import 'package:drive_thru/src/screens/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drive_thru/src/services/resturantManagement.dart';
import '../shared/styles.dart';
import '../shared/colors.dart';
import 'dart:core';

import 'Dashboard.dart';

class AddResturant extends StatefulWidget {
  @override
  _AddResturantState createState() => _AddResturantState();
}

class _AddResturantState extends State<AddResturant>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  var _foodTypes = ['Fast Food', 'Slow Food' ,'Sleepy Food', 'Other'];
  var _selectedType = 'Slow Food';
  String _restName;
  String _address;
  String _zipCode;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: bgColor,
          centerTitle: true,
          leading: BackButton(
            color: darkText,
            onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){return new DashBoard(); }));
            },
          ),
          title: Text("Add a Resturant", style: h4),
        ),
        body: ListView(children: <Widget>[
          Container(
            
            child: Stack(
              children: <Widget>[
                Column(children: <Widget>[
                  Container(
                    child:TextField(
                      onChanged: (value){
                        setState(() {
                          _restName = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Resturant Name'
                      ),
                    ),
                  ),
                  Container(
                    child:TextField(
                      onChanged: (value){
                        setState(() {
                          _address = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Address'
                      ),
                    ),
                  ),
                  Container(
                    child:TextField(
                      onChanged: (value){
                        setState(() {
                          _zipCode = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'ZIP Code'
                      ),
                    ),
                  ),
                  Container(
                    child:DropdownButton<String>(
                      items: _foodTypes.map((String dropDownStringItem){
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      onChanged: (value){
                        setState(() {
                          _selectedType = value;
                        });
                      },
                      value: _selectedType,
                    ),
                  ),
                  Container(
                    child: FlatButton(
                      onPressed: (){
                        ResturantManagement().addNewResturant(context ,_restName, _address, _zipCode, _selectedType);
                      },
                      color: Colors.blue,
                      child: Icon(Icons.add,color: white,),
                    ),
                  ),
                ],)
                
              ],
              
            ),
          ),
        ],),
    );
  }
}