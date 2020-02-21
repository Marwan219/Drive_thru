import 'dart:io';
import 'package:drive_thru/src/services/resturantManagement.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../shared/styles.dart';
import 'dart:core';
import '../shared/buttons.dart';

class User {
  static const String PassionCooking = 'cooking';
  static const String PassionHiking = 'hiking';
  static const String PassionTraveling = 'traveling';
  String firstName = '';
  String lastName = '';
  String restname = '';
  String latitude = '';
  String longitude = '';
  String gmNum = '';
  String gmName = '';
  String branNum = '';
  String gmMail= '';
  String hqLocation= '';
  String hotLine= '';
  String restNum= '';
  String restNum2= '';
  bool newsletter = false;
  
}


class AddResturant extends StatefulWidget {
  @override
  _AddResturantState createState() => _AddResturantState();
}


final _formKey = GlobalKey<FormState>();


class _AddResturantState extends State <AddResturant> {
  final _user = User();
  File _image = new File('/images/6.png'); 

  
  Map<String, dynamic> restmap = {
    'firstName' : '',
    'lastName' : '',
    'restname' : '',
    'latitude' : '',
    'longitude' : '',
    'gmNum' : '',
    'gmName' : '',
    'branNum' : '',
    'gmMail': '',
    'hqLocation': '',
    'hotLine': '',
    'restNum': '',
    'restNum2': '',
    'newsletter' : false,
  };
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
        appBar: AppBar(title: Text('Add new Restaurant', style: logoWhiteStyle, textAlign: TextAlign.center),),
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
                                InputDecoration(labelText: 'Restaurant Name'),
                            
                            onSaved: (val) =>
                                setState(() => _user.restname = val),
                                validator: (value) {
                              if (value.isEmpty) {
                                return('Please enter the Restaurant Name') ;
                              }
                            },
                          ),
                          TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Number of branches'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Please enter the restaurant's number of branches";
                                }
                              },
                              onSaved: (val) =>
                                  setState(() => _user.branNum = val)),
                                  TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Where is your head quarter in egypt?'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Please enter the location of the restaurant's head quarter";
                                }
                              },
                              onSaved: (val) =>
                                  setState(() => _user.hqLocation = val)),
                                  TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Kindly enter the latitude'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter the latitude';
                                }
                              },
                              onSaved: (val) =>
                                  setState(() => _user.latitude = val)),
                                  TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Kindly enter the longitude'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter the longitude';
                                }
                              },
                              onSaved: (val) =>
                                  setState(() => _user.longitude = val)),
                                  TextFormField(
                              decoration:
                                  InputDecoration(labelText: "Restaurant's Hotline (optional)"),
                        
                              onSaved: (val) =>
                                  setState(() => _user.hotLine = val)),
                                  TextFormField(
                              decoration:
                                  InputDecoration(labelText: "Restaurant's Phone number"),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Please enter the Restaurant's Phone number";
                                }
                              },
                              onSaved: (val) =>
                                  setState(() => _user.restNum = val)),
                                  TextFormField(
                              decoration:
                                  InputDecoration(labelText: "Kindly enter another phone number"),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Kindly enter another phone number";
                                }
                              },
                              onSaved: (val) =>
                                  setState(() => _user.restNum2 = val)),
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
                                  TextFormField(
                              decoration:
                                  InputDecoration(labelText: "Kindly eneter the GM's name"),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Kindly eneter the GM's name";
                                }
                              },
                              onSaved: (val) =>
                                  setState(() => _user.gmName = val)),
                                  TextFormField(
                              decoration:
                                  InputDecoration(labelText: "Kindly eneter the GM's phone number"),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Kindly eneter the GM's phone number";
                                }
                              },
                              onSaved: (val) =>
                                  setState(() => _user.gmNum = val)),
                                  TextFormField(
                              decoration:
                                  InputDecoration(labelText: "Kindly eneter the GM's E-mail address"),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Kindly eneter the GM's E-mail address";
                                }
                              },
                              onSaved: (val) =>
                                  setState(() => _user.gmMail = val)),
                                
                          Container(
                            padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
                            child: Text('Recieve our apps recent news?'),
                          ),
                          SwitchListTile(
                              title: const Text('Monthly Newsletter'),
                              value: _user.newsletter,
                              onChanged: (bool val) =>
                                  setState(() => _user.newsletter = val)),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 16.0),
                                  child: froyoOutlineBtn(('Submit'),( ){
                                    // uploadFile();
                                    final form = _formKey.currentState;
                                    if (form.validate()) {
                                      form.save();
                                    
                                    }
                                    restmap['firstName'] = _user.firstName;
                                    restmap['lastName'] = _user.lastName;
                                    restmap['restname'] = _user.restname;
                                    restmap['latitude'] = _user.latitude;
                                    restmap['longitude'] = _user.longitude;
                                    restmap['gmNum'] = _user.gmNum;
                                    restmap['gmName'] = _user.gmName;
                                    restmap['branNum'] = _user.branNum;
                                    restmap['gmMail'] = _user.gmMail;
                                    restmap['hqLocation'] = _user.hqLocation;
                                    restmap['hotLine'] = _user.hotLine;
                                    restmap['restNum'] = _user.restNum;
                                    restmap['restNum2'] = _user.restNum2;
                                    restmap['newsletter'] = _user.newsletter;
                                    print(_user);
                                    //Image_picker();
                                    ResturantManagement().addNewResturant(context,
                                      firstName: _user.firstName,
                                      lastName: _user.lastName,
                                      restname: _user.restname,
                                      latitude: _user.latitude,
                                      longitude: _user.longitude,
                                      gmNum: _user.gmNum,
                                      gmName: _user.gmName,
                                      branNum: _user.branNum,
                                      gmMail: _user.gmMail,
                                      hqLocation: _user.hqLocation,
                                      hotLine: _user.hotLine,
                                      restNum: _user.restNum,
                                      restNum2: _user.restNum2,
                                      newsletter: _user.newsletter
                                    );
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