import 'dart:io';
import 'package:drive_thru/src/screens/Dashboard.dart';
import 'package:drive_thru/src/screens/Image_picker.dart';
import 'package:drive_thru/src/services/MenuManagement.dart';
import 'package:drive_thru/src/services/resturantManagement.dart';
import 'package:drive_thru/src/shared/colors.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path/path.dart' as Path;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../shared/styles.dart';
import 'dart:core';
import '../shared/buttons.dart';


class Menue {
  static const String PassionCooking = 'cooking';
  static const String PassionHiking = 'hiking';
  static const String PassionTraveling = 'traveling';
  String mealName = '';
  double mealPrice = 0.0 ;
  int timeToDone  = 0;
  bool newsletter = false;
  
}


class AddMenue extends StatefulWidget {
  final String docID;
  AddMenue({this.docID});
  @override
  _AddMenueState createState() => _AddMenueState();
}


final _formKey = GlobalKey<FormState>();


class _AddMenueState extends State <AddMenue> {
  final _menue = Menue();
  

  // File _image = new File('/images/6.png'); 

  
  Map<String, dynamic> menueMap = {
    'mealName' : '',
    'mealPrice' : 0.0,
    'timeToDone' : 0,
    //'FoodType' : '',
    'newsletter' : false,
  };
  var _foodTypes = ['Soft Drinks', 'Hot Drinks' ,'Main Plates', 'Other'];
  var _selectedType = 'Hot Drinks';
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar( leading: BackButton(
            color: darkText,
            onPressed: (){
              //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){return new DashBoard(); }));
            },
          ),
          title: Text('Add Menue', style: logoWhiteStyle, textAlign: TextAlign.center),),
        body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Builder(
                builder: (context) => Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Meal Name'),
                            
                            onSaved: (val) =>
                                setState(() => _menue.mealName = val),
                                validator: (value) {
                              if (value.isEmpty) {
                                return('Please enter Meal Name') ;
                              }
                            },
                          ),
                          TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Price'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Please enter the price of the meal";
                                }
                              },
                              onSaved: (val) =>
                                  setState(() => _menue.mealPrice = double.parse(val))),
                                  TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Time To Done?'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Please enter the excepctaion time";
                                }
                              },
                              onSaved: (val) =>
                                  setState(() => _menue.timeToDone = int.parse(val))),
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
                            padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
                            child: Text('Recieve our apps recent news?'),
                          ),
                          SwitchListTile(
                              title: const Text('Monthly Newsletter'),
                              value: _menue.newsletter,
                              onChanged: (bool val) =>
                                  setState(() => _menue.newsletter = val)),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 16.0),
                                  child: froyoOutlineBtn(('Submit'),( ){
                                    // uploadFile();
                                    final form = _formKey.currentState;
                                    if (form.validate()) {
                                      form.save();
                                    
                                    }
                                    menueMap['mealName'] = _menue.mealName;
                                    menueMap['mealPrice'] = _menue.mealPrice;
                                    menueMap['timeToDone'] = _menue.timeToDone;
                                    menueMap['newsletter'] = _menue.newsletter;
                                    MenuManagement().addMenuItem(context, mealName:  _menue.mealName, mealPrice: _menue.mealPrice, timeToDone: _menue.timeToDone, newsletter: _menue.newsletter, docID: widget.docID);
                                  })
                          ),
                        ])
                )
            )
          )
        ]
        )
    );
  }
}