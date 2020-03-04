import 'package:drive_thru/src/services/walletMangement.dart';
import 'package:drive_thru/src/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drive_thru/src/screens/menu.dart';
import 'package:drive_thru/src/shared/partials.dart';
import 'package:flutter/material.dart';
import 'package:drive_thru/src/screens/AddResturant.dart';
import 'package:drive_thru/src/screens/HomePage.dart';
import 'package:drive_thru/src/services/FetshingData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:page_transition/page_transition.dart';
import '../../root.dart';
import '../shared/styles.dart';
import '../shared/colors.dart';
import './Carts.dart';
import './survey.dart';
import './NewDashboard.dart';
import '../shared/colors.dart';
import '../shared/buttons.dart';


class Wallet extends StatefulWidget {
  double balance=0;
  String addedvalue="";
  String _useremail;
  Wallet({Key key}) : super(key: key);

  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
     Firestore.instance
        .collection("users")
        .document(uID) // uID is global variabe passed by root page
        .get()
        .then((DocumentSnapshot userWallet) {
      setState(() {
        widget.balance = userWallet.data["wallet"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text('Your Timpo Wallet',
            style: logoWhiteStyle, textAlign: TextAlign.center),
      ),
      drawer: new Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Timpo',
                  style: logoWhiteStyle, textAlign: TextAlign.center),
              decoration: BoxDecoration(
                color: Colors.orange,
              ),
            ),
            ListTile(
              title: Text('Home Page'),
              onTap: () {
                Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child: NewDashboard()));
              },
            ),
            ListTile(
              title: Text('Wallet'),
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.leftToRightWithFade,
                        child: Wallet()));
              },
            ),
            ListTile(
                title: Text('Map'),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) => new AlertDialog(
                            title: new Text("Comming soon"),
                            content:
                                new Text("Timpo Map will be coming soon 🙂"),
                          ));
                }),
            ListTile(
              title: Text('Settings'),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text('Let Us know what you think.. 🙂'),
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.leftToRightWithFade,
                        child: Survey()));
              },
            ),
          ],
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          left: 20,
          top: 30,
        ),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Your Balance",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                child: colorCard(
                    "Cash", widget.balance, 1, context, Color(0xFFA500)),
              )
            ],
          ),
          SizedBox(
            height: 40,
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Charging Method :",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Paymentcard("Cash💵", context, Color(0xFFA500)),
            ],
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  Widget colorCard(
      String text, double amount, int type, BuildContext context, Color color) {
    final _media = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 15, right: 15),
      padding: EdgeInsets.all(15),
      width: _media.width * 0.8,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: color.withOpacity(1),
                blurRadius: 0,
                spreadRadius: 0.2,
                offset: Offset(0, 8)),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "${type > 0 ? "" : "-"} \$ ${amount.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  Widget Paymentcard(String text, BuildContext context, Color color) {
    final _media = MediaQuery.of(context).size;
    return Container(
      child: OutlineButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) => new AlertDialog(
                    title: new Text("Charge"),
                    content: new Container(
                        width: MediaQuery.of(context).size.width * 0.15,
                        height: MediaQuery.of(context).size.width * 0.40,
                        child: Column(
                          children: <Widget>[
                            TextField(
                              onChanged: (value) {
                                  widget.addedvalue=value;
                              },
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: primaryColor,
                              style: inputFieldTextStyle,
                              decoration: InputDecoration(
                                  hintText: 'Value',
                                  hintStyle: inputFieldHintTextStyle,
                                  focusedBorder: inputFieldFocusedBorderStyle,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  border: inputFieldDefaultBorderStyle),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              onChanged: (value) {
                                widget._useremail = value;
                              },
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: primaryColor,
                              style: inputFieldTextStyle,
                              decoration: InputDecoration(
                                  hintText: 'Email',
                                  hintStyle: inputFieldHintTextStyle,
                                  focusedBorder: inputFieldFocusedBorderStyle,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  border: inputFieldDefaultBorderStyle),
                            ),
                            froyoFlatBtn('Add Amount', () {
                              
                              // WalletMangement().addTowallet(this.addedvalue,context,uID);
                              WalletMangement().updatewalletbymail(context,
                                  useremail: widget._useremail,
                                  value: widget.addedvalue);
                            }),
                          ],
                        )),
                  ));
        },
        child: Text(text),
        textColor: primaryColor,
        highlightedBorderColor: highlightColor,
        borderSide: BorderSide(color: primaryColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      width: _media.width * .80,
    );
  }
}
