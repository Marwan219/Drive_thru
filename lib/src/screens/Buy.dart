import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drive_thru/src/screens/Orders.dart';
import 'package:drive_thru/src/services/walletMangement.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import './Timerpage.dart';
import '../shared/styles.dart';
import '../shared/colors.dart';

enum SingingCharacter { car, walk }

class Buy extends StatefulWidget {
  double price = 0;
  List data = [
    {"car_number": "", "car_color": "", "car_Type": "", "car_model": ""},
    {
      "w_Phone Number": "",
      "w_Name": "",
    },
  ];

  bool car_visible = false;
  bool walk_visible = true;
  bool isSwitched = true;
  Widget okBton = FlatButton(
    child: Text("OK"),
    onPressed: () {},
  );
  final String pageTitle;
  final double productPrice;
  final int product_quantity;
  final int timeToDone;
  final String resturantID;
  List coins = [
    {"value": 1, "checked": false},
    {"value": 5, "checked": false},
    {"value": 10, "checked": false},
    {"value": 20, "checked": false},
    {"value": 50, "checked": false},
    {"value": 100, "checked": false},
    {"value": 200, "checked": false}
  ];
  Buy({Key key, this.pageTitle, this.productPrice, this.product_quantity, this.timeToDone, this.resturantID})
      : super(key: key);
  @override
  _BuyState createState() => _BuyState();
}

class _BuyState extends State<Buy> {
  @override
  SingingCharacter _character = SingingCharacter.walk;

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            iconSize: 21,
            icon: Icon(
              Icons.arrow_back_ios,
              color: white,
            )),
        backgroundColor: primaryColor,
        title: Text('Check Out',
            style: logoWhiteStyle, textAlign: TextAlign.center),
      ),
      body: ListView(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(top: 1, bottom: 10),
              padding: EdgeInsets.only(top: 10, bottom: 10, left: 6, right: 10),
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: rescardstyle,
              child: Column(children: <Widget>[
                Text(
                  " Bill ",
                  style: h3,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Items",
                      style: h4,
                    ),
                    Spacer(
                      flex: 5,
                    ),
                    Text(
                      "Quantiy",
                      style: h4,
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Text(
                      "Price",
                      style: h4,
                    )
                  ],
                ),
                Divider(),
                Container(
                    margin: EdgeInsets.only(top: 1, bottom: 2),
                    child: Row(
                      children: <Widget>[
                        Text(
                          widget.pageTitle,
                          style: h4,
                        ),
                        Spacer(
                          flex: 5,
                        ),
                        Text(
                          widget.product_quantity.toString(),
                          style: h4,
                        ),
                        Spacer(
                          flex: 3,
                        ),
                        Text(
                          ((
                                      widget.productPrice *
                                  widget.product_quantity)
                              .toString()),
                          style: h4,
                        ),
                      ],
                    )),
                Divider(),
                Container(
                    margin: EdgeInsets.only(top: 1, bottom: 2),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Total price",
                          style: h5,
                        ),
                        Spacer(
                          flex: 5,
                        ),
                        Text(
                          ((
                            widget.productPrice *
                            widget.product_quantity)
                              .toString()),
                          style: h4,
                        ),
                      ],
                    )),
              ])),
          Container(
              padding: EdgeInsets.only(top: 4, bottom: 7, left: 15, right: 10),
              margin: EdgeInsets.only(top: 5, bottom: 2),
              decoration: rescardstyle,
              child: Center(
                  child: Text(
                "Choose Available coins",
                style: h4,
              ))),
          Container(
            height: 200,
            padding: EdgeInsets.only(top: 4, bottom: 1, left: 15, right: 10),
            margin: EdgeInsets.only(top: 1, bottom: 2),
            decoration: rescardstyle,
            child: ListView(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      widget.coins[0]["value"].toString(),
                      style: h5,
                    ),
                    Spacer(
                      flex: 5,
                    ),
                    Switch(
                      value: widget.coins[0]["checked"],
                      onChanged: (value) {
                        setState(() {
                          widget.coins[0]["checked"] = value;
                        });
                      },
                      activeTrackColor: Colors.lightGreenAccent,
                      activeColor: Colors.green,
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      widget.coins[1]["value"].toString(),
                      style: h5,
                    ),
                    Spacer(
                      flex: 5,
                    ),
                    Switch(
                      value: widget.coins[1]["checked"],
                      onChanged: (value) {
                        setState(() {
                          widget.coins[1]["checked"] = value;
                        });
                      },
                      activeTrackColor: Colors.lightGreenAccent,
                      activeColor: Colors.green,
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      widget.coins[2]["value"].toString(),
                      style: h5,
                    ),
                    Spacer(
                      flex: 5,
                    ),
                    Switch(
                      value: widget.coins[2]["checked"],
                      onChanged: (value) {
                        setState(() {
                          widget.coins[2]["checked"] = value;
                        });
                      },
                      activeTrackColor: Colors.lightGreenAccent,
                      activeColor: Colors.green,
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      widget.coins[3]["value"].toString(),
                      style: h5,
                    ),
                    Spacer(
                      flex: 5,
                    ),
                    Switch(
                      value: widget.coins[3]["checked"],
                      onChanged: (value) {
                        setState(() {
                          widget.coins[3]["checked"] = value;
                        });
                      },
                      activeTrackColor: Colors.lightGreenAccent,
                      activeColor: Colors.green,
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      widget.coins[4]["value"].toString(),
                      style: h5,
                    ),
                    Spacer(
                      flex: 5,
                    ),
                    Switch(
                      value: widget.coins[4]["checked"],
                      onChanged: (value) {
                        setState(() {
                          widget.coins[4]["checked"] = value;
                        });
                      },
                      activeTrackColor: Colors.lightGreenAccent,
                      activeColor: Colors.green,
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      widget.coins[5]["value"].toString(),
                      style: h5,
                    ),
                    Spacer(
                      flex: 5,
                    ),
                    Switch(
                      value: widget.coins[5]["checked"],
                      onChanged: (value) {
                        setState(() {
                          widget.coins[5]["checked"] = value;
                        });
                      },
                      activeTrackColor: Colors.lightGreenAccent,
                      activeColor: Colors.green,
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      widget.coins[6]["value"].toString(),
                      style: h5,
                    ),
                    Spacer(
                      flex: 5,
                    ),
                    Switch(
                      value: widget.coins[6]["checked"],
                      onChanged: (value) {
                        setState(() {
                          widget.coins[6]["checked"] = value;
                        });
                      },
                      activeTrackColor: Colors.lightGreenAccent,
                      activeColor: Colors.green,
                    ),
                  ],
                )
              ],
            ),
          ),
          Column(
            children: <Widget>[
              Container(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 1, left: 5, right: 10),
                  margin: EdgeInsets.only(top: 10, bottom: 2),
                  decoration: rescardstyle,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Please Choose Delivery option",
                        style: h6,
                      ),
                      RadioListTile<SingingCharacter>(
                        title: const Text('Car'),
                        value: SingingCharacter.car,
                        groupValue: _character,
                        onChanged: (SingingCharacter value) {
                          setState(() {
                            _character = value;
                            widget.car_visible = true;
                            widget.walk_visible = false;
                          });
                        },
                      ),
                      RadioListTile<SingingCharacter>(
                        title: const Text('Walk'),
                        value: SingingCharacter.walk,
                        groupValue: _character,
                        onChanged: (SingingCharacter value) {
                          setState(() {
                            _character = value;
                            widget.walk_visible = true;
                            widget.car_visible = false;
                          });
                        },
                      ),
                    ],
                  )),
              Container(
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: <Widget>[
                          Visibility(
                            visible: widget.car_visible ? false : true,
                            child: Container(
                                margin: EdgeInsets.only(
                                    top: 10, bottom: 10, left: 6, right: 10),
                                padding: EdgeInsets.only(
                                    top: 10, bottom: 10, left: 6, right: 10),
                                decoration: rescardstyle,
                                child: Column(children: <Widget>[
                                  Text(
                                    " Enter Your Information ",
                                    style: h3,
                                  ),
                                  Divider(),
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        "Phone Number",
                                        style: h4,
                                      ),
                                      Divider(),
                                      TextField(
                                        onChanged: (value) {
                                          widget.data[1]["w_Phone Number"] =
                                              value;
                                        },
                                        cursorColor: primaryColor,
                                        style: inputFieldTextStyle,
                                        decoration: InputDecoration(
                                            hintText: '012**67',
                                            hintStyle: inputFieldHintTextStyle,
                                            focusedBorder:
                                                inputFieldFocusedBorderStyle,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 10),
                                            border:
                                                inputFieldDefaultBorderStyle),
                                      ),
                                      Divider(),
                                      Text(
                                        "Name",
                                        style: h4,
                                      ),
                                      Divider(),
                                      TextField(
                                        onChanged: (value) {
                                          widget.data[1]["w_Name"] = value;
                                        },
                                        cursorColor: primaryColor,
                                        style: inputFieldTextStyle,
                                        decoration: InputDecoration(
                                            hintText: 'Ahmed',
                                            hintStyle: inputFieldHintTextStyle,
                                            focusedBorder:
                                                inputFieldFocusedBorderStyle,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 10),
                                            border:
                                                inputFieldDefaultBorderStyle),
                                      ),
                                      Divider(),
                                    ],
                                  ),
                                ])),
                          ),
                          Visibility(
                            
                            visible: widget.car_visible ? true : false,
                            //duration: Duration(milliseconds: 200),

                            // The green box must be a child of the AnimatedOpacity widget.
                            child: Container(

                                // height: 300,
                                margin: EdgeInsets.only(
                                    top: 10, bottom: 10, left: 6, right: 10),
                                padding: EdgeInsets.only(
                                    top: 10, bottom: 10, left: 6, right: 10),
                                //  width: MediaQuery.of(context).size.width * 0.85,

                                decoration: rescardstyle,
                                child: Column(children: <Widget>[
                                  Text(
                                    " Enter car spec ",
                                    style: h3,
                                  ),
                                  Divider(),
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        "Number",
                                        style: h4,
                                      ),
                                      Divider(),
                                      TextField(
                                        onChanged: (value) {
                                          widget.data[0]["car_number"] = value;
                                        },
                                        cursorColor: primaryColor,
                                        style: inputFieldTextStyle,
                                        decoration: InputDecoration(
                                            hintText: 'ABC 123',
                                            hintStyle: inputFieldHintTextStyle,
                                            focusedBorder:
                                                inputFieldFocusedBorderStyle,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 10),
                                            border:
                                                inputFieldDefaultBorderStyle),
                                      ),
                                      Divider(),
                                      Text(
                                        "Color",
                                        style: h4,
                                      ),
                                      Divider(),
                                      TextField(
                                        onChanged: (value) {
                                          widget.data[0]["car_color"] = value;
                                        },
                                        cursorColor: primaryColor,
                                        style: inputFieldTextStyle,
                                        decoration: InputDecoration(
                                            hintText: 'Red',
                                            hintStyle: inputFieldHintTextStyle,
                                            focusedBorder:
                                                inputFieldFocusedBorderStyle,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 10),
                                            border:
                                                inputFieldDefaultBorderStyle),
                                      ),
                                      Divider(),
                                      Text(
                                        "Model",
                                        style: h4,
                                      ),
                                      Divider(),
                                      TextField(
                                        onChanged: (value) {
                                          widget.data[0]["car_model"] = value;
                                        },
                                        cursorColor: primaryColor,
                                        style: inputFieldTextStyle,
                                        decoration: InputDecoration(
                                            hintText: 'BMW',
                                            hintStyle: inputFieldHintTextStyle,
                                            focusedBorder:
                                                inputFieldFocusedBorderStyle,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 10),
                                            border:
                                                inputFieldDefaultBorderStyle),
                                      )
                                    ],
                                  ),
                                ])),
                          ),
                        ],
                      )))
            ],
          ),
          Container(
              padding: EdgeInsets.only(top: 10, bottom: 1, left: 5, right: 10),
              margin: EdgeInsets.only(top: 10, bottom: 2),
              decoration: rescardstyle,
              child: FlatButton(
                onPressed: () async {

                  await WalletMangement().walletdecrease(context, widget.productPrice *
                            widget.product_quantity);
                            
                  if (order_booked==true){
                 await Firestore.instance.collection('/Restaurants').document(widget.resturantID).collection('Orders').add({
                    'Meal Name' : widget.pageTitle,
                    'Meal Price' : widget.productPrice,
                    'Units' : widget.product_quantity,
                    'Time To Done' : widget.timeToDone
                  }).then((value){
                    Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.leftToRight, child: Orders()));
                  }).catchError((e){print(e);});
                            
                }
                
                },
                child: Text('Buy', style: contrastTextBold),
              ))
        ],
      ),
    );
  }
}
