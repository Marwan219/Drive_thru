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
  String zipcode = '';
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
  

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                  InputDecoration(labelText: 'Kindly enter the Zip Code'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter the Zip Code';
                                }
                              },
                              onSaved: (val) =>
                                  setState(() => _user.zipcode = val)),
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
                                    final form = _formKey.currentState;
                                    if (form.validate()) {
                                      form.save();
                                    
                                    }

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