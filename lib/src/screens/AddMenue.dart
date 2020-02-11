import 'dart:io';
import 'package:drive_thru/src/screens/Dashboard.dart';
import 'package:drive_thru/src/screens/Image_picker.dart';
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
  String mealPrice = '';
  String timeToDone = '';
  // String latitude = '';
  // String longitude = '';
  // String gmNum = '';
  // String gmName = '';
  // String branNum = '';
  // String gmMail= '';
  // String hqLocation= '';
  // String hotLine= '';
  // String restNum= '';
  // String restNum2= '';
  bool newsletter = false;
  
}


class AddMenue extends StatefulWidget {
  @override
  _AddMenueState createState() => _AddMenueState();
}


final _formKey = GlobalKey<FormState>();


class _AddMenueState extends State <AddMenue> {
  final _menue = Menue();
  // File _image = new File('/images/6.png'); 

  
  Map<String, dynamic> menueMap = {
    'mealName' : '',
    'mealPrice' : '',
    'timeToDone' : '',
    // 'latitude' : '',
    // 'longitude' : '',
    // 'gmNum' : '',
    // 'gmName' : '',
    // 'branNum' : '',
    // 'gmMail': '',
    // 'hqLocation': '',
    // 'hotLine': '',
    // 'restNum': '',
    // 'restNum2': '',
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
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){return new DashBoard(); }));
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
                                  setState(() => _menue.mealPrice = val)),
                                  TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Time To Done?'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Please enter the excepctaion time";
                                }
                              },
                              onSaved: (val) =>
                                  setState(() => _menue.timeToDone = val)),
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
                              //     TextFormField(
                              // decoration:
                              //     InputDecoration(labelText: 'Kindly enter the latitude'),
                              // validator: (value) {
                              //   if (value.isEmpty) {
                              //     return 'Please enter the latitude';
                              //   }
                              // },
                              // onSaved: (val) =>
                              //     setState(() => _user.latitude = val)),
                              //     TextFormField(
                              // decoration:
                              //     InputDecoration(labelText: 'Kindly enter the longitude'),
                              // validator: (value) {
                              //   if (value.isEmpty) {
                              //     return 'Please enter the longitude';
                              //   }
                              // },
                              // onSaved: (val) =>
                              //     setState(() => _user.longitude = val)),
                              //     TextFormField(
                              // decoration:
                              //     InputDecoration(labelText: "Restaurant's Hotline (optional)"),
                        
                              // onSaved: (val) =>
                              //     setState(() => _user.hotLine = val)),
                              //     TextFormField(
                              // decoration:
                              //     InputDecoration(labelText: "Restaurant's Phone number"),
                              // validator: (value) {
                              //   if (value.isEmpty) {
                              //     return "Please enter the Restaurant's Phone number";
                              //   }
                              // },
                              // onSaved: (val) =>
                              //     setState(() => _user.restNum = val)),
                              //     TextFormField(
                              // decoration:
                              //     InputDecoration(labelText: "Kindly enter another phone number"),
                              // validator: (value) {
                              //   if (value.isEmpty) {
                              //     return "Kindly enter another phone number";
                              //   }
                              // },
                              // onSaved: (val) =>
                              //     setState(() => _user.restNum2 = val)),
                              //     TextFormField(
                              // decoration:
                              //     InputDecoration(labelText: "Restaurant's image"),
                              // validator: (value) {
                              //   if (value.isEmpty) {
                              //     return "Please enter the Restaurant's image";
                              //   }
                              // },
                              // onSaved: (val) =>
                              //     setState(() => _user.imageURL = val)),
                              //     TextFormField(
                              // decoration:
                              //     InputDecoration(labelText: "Kindly eneter the GM's name"),
                              // validator: (value) {
                              //   if (value.isEmpty) {
                              //     return "Kindly eneter the GM's name";
                              //   }
                              // },
                              // onSaved: (val) =>
                              //     setState(() => _user.gmName = val)),
                              //     TextFormField(
                              // decoration:
                              //     InputDecoration(labelText: "Kindly eneter the GM's phone number"),
                              // validator: (value) {
                              //   if (value.isEmpty) {
                              //     return "Kindly eneter the GM's phone number";
                              //   }
                              // },
                              // onSaved: (val) =>
                              //     setState(() => _user.gmNum = val)),
                              //     TextFormField(
                              // decoration:
                              //     InputDecoration(labelText: "Kindly eneter the GM's E-mail address"),
                              // validator: (value) {
                              //   if (value.isEmpty) {
                              //     return "Kindly eneter the GM's E-mail address";
                              //   }
                              // },
                              // onSaved: (val) =>
                              //     setState(() => _user.gmMail = val)),
                                
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
                                    menueMap['firstName'] = _menue.mealName;
                                    menueMap['lastName'] = _menue.mealPrice;
                                    menueMap['restname'] = _menue.timeToDone;
                                    // menueMap['latitude'] = _user.latitude;
                                    // menueMap['longitude'] = _user.longitude;
                                    // menueMap['gmNum'] = _user.gmNum;
                                    // menueMap['gmName'] = _user.gmName;
                                    // menueMap['branNum'] = _user.branNum;
                                    // menueMap['gmMail'] = _user.gmMail;
                                    // menueMap['hqLocation'] = _user.hqLocation;
                                    // menueMap['hotLine'] = _user.hotLine;
                                    // menueMap['restNum'] = _user.restNum;
                                    // menueMap['restNum2'] = _user.restNum2;
                                    menueMap['newsletter'] = _menue.newsletter;
                                    print(_menue);
                                    //Image_picker();
                                   // ResturantManagement().addNewResturant(context, menueMap);
                                    //Navigator.push(context, PageTransition(type: PageTransitionType.leftToRight, child: Image_picker()));
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