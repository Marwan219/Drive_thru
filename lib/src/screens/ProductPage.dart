import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../shared/Product.dart';
import '../shared/styles.dart';
import '../shared/colors.dart';
import '../shared/partials.dart';
import '../shared/buttons.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:drive_thru/src/screens/AddResturant.dart';
import 'package:drive_thru/src/screens/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Buy.dart';
import 'Timerpage.dart';
import 'Dashboard.dart';
import '../../generated/intl/l10n.dart';
import '../../generated/intl/helper.dart';
import '../services/flutter_restart.dart';
import 'package:drive_thru/src/screens/Timerpage.dart';
import 'package:drive_thru/src/services/FetshingData.dart';

class ProductPage extends StatefulWidget {
  final String pageTitle;
  final Product productData;
  //final int time1;

  ProductPage({Key key, this.pageTitle, this.productData}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  double _rating = 4;
  int _quantity = 1;

   Future<void> languageChange() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title:Center(child:Text(AppLocalizations.of(context).language),) ,
        // elevation: 40.0,
      
        actions: <Widget>[
          Column(
            children: <Widget>[
             Container(
               width:MediaQuery.of(context).size.width   ,
               child:OutlineButton(
              shape: new Border.all(width: 2,color: Colors.black),
              child: new Text("English"), onPressed: (){
                  this.setState((){
                   helper.onLocaleChanged(new Locale("en"));
                    language = "en";
                   RestartWidget.of(context).restartApp();
                  });}),),
                 
                     Divider(
                              color: Colors.black,
                            ),
               Container(
                 width:MediaQuery.of(context).size.width,
                 child: OutlineButton(
                shape: new Border.all(width: 2,color: Colors.black),
              child: new Text("عربى"), onPressed: (){
                  this.setState((){
                   helper.onLocaleChanged(new Locale("ar"));
                    language = "ar";
                   RestartWidget.of(context).restartApp();
                  });}),),
              
                  Divider(),
              
            RaisedButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          )

        ],
      );
    },
  );
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
          ),
          title: Text(widget.productData.name, style: h4),
        ),
        drawer: new Drawer(  
        child: ListView(

          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Virtual DriveThru', style: logoWhiteStyle, textAlign: TextAlign.center),
              decoration: BoxDecoration(
                color: Colors.orange,
              ),
            ),
            ListTile(
              title: Text(''),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context).homePage),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context).myProfile),
              
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context).store),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context).addResturant),
              onTap: () {
                Navigator.push(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: AddResturant()));
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context).setting),
              
              onTap: () {
                Navigator.push(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: FetshingData()));
                
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context).timerPage),
              
              onTap: () {
                Navigator.push(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: TimerPage()));
                
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context).language),
              onTap: () {
                this.languageChange();
              },
            ),
               Divider(
                              color: Colors.black,
                            ),
            ListTile(
              title: Text(AppLocalizations.of(context).signOut),
              onTap: () {
                FirebaseAuth.instance.signOut().then((value){
                Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: HomePage()));
                }).catchError((e){print(e);});
              },
            )
          ],
        ),
      ),
        body: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Center(
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                      margin: EdgeInsets.only(top: 100, bottom: 100),
                      padding: EdgeInsets.only(top: 100, bottom: 50),
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(widget.productData.name, style: h5),
                          Text(widget.productData.price, style: h3),
                          Container(
                            margin: EdgeInsets.only(top: 5, bottom: 20),
                            child: SmoothStarRating(
                              allowHalfRating: false,
                              onRatingChanged: (v) {
                                setState(() {
                                  _rating = v;
                                });
                              },
                              starCount: 5,
                              rating: _rating,
                              size: 27.0,
                              color: Colors.orange,
                              borderColor: Colors.orange,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10, bottom: 25),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Text(AppLocalizations.of(context).quantity, style: h6),
                                  margin: EdgeInsets.only(bottom: 15),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: 55,
                                      height: 55,
                                      child: OutlineButton(
                                        onPressed: () {
                                          setState(() {
                                            _quantity += 1;
                                          });
                                        },
                                        child: Icon(Icons.add),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 20, right: 20),
                                      child: Text(_quantity.toString(), style: h3),
                                    ),
                                    Container(
                                      width: 55,
                                      height: 55,
                                      child: OutlineButton(
                                        onPressed: () {
                                          setState(() {
                                           if(_quantity == 1) return;
                                             _quantity -= 1; 
                                          });
                                        },
                                        child: Icon(Icons.remove),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 180,
                            child: froyoOutlineBtn(AppLocalizations.of(context).buyNowbtn, () {
                              Firestore.instance.collection('/Orders').add({
                                'Item Name' : widget.productData.name,
                                'Item Price' : widget.productData.price,
                                //'Duration' :Duration,
                                'Units' : _quantity 
                              }).then((value){
                                //Navigator.of(context).pop();
                                Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.leftToRight, child: Buy(pageTitle: widget.pageTitle,productData: widget.productData,product_quantity:_quantity,)));
                              }).catchError((e){print(e);});
                            }),
                          ),
                          Container(
                            width: 180,
                            child: froyoFlatBtn(AppLocalizations.of(context).addToCartbtn, () {}),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 15,
                                spreadRadius: 5,
                                color: Color.fromRGBO(0, 0, 0, .05))
                          ]),
                    ),
                    ),
                    Align(
                        alignment: Alignment.center,
                      child: SizedBox(
                        width: 200,
                        height: 160,
                        child: foodItem(widget.productData,
                            isProductPage: true,
                            onTapped: () {},
                            imgWidth: 250,
                            onLike: () {}),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
