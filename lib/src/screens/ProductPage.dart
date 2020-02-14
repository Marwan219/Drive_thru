import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drive_thru/src/screens/Carts.dart';
import 'package:drive_thru/src/services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../services/CartManagement.dart';
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

class ProductPage extends StatefulWidget {
  final String pageTitle;
  final double productprice;
  final int timeToDone;

  ProductPage({Key key, this.pageTitle, this.productprice, this.timeToDone}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  double _rating = 4;
  int _quantity = 1;
  String id = '';

  void initState(){
  FirebaseAuth.instance.currentUser().then((user){
    setState(() {
      id = user.uid;
    });  
  }) ;
  }
  
  @override
  Widget build(BuildContext context) {
    print(id);
    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: bgColor,
          centerTitle: true,
          leading: BackButton(
            color: darkText,
          ),
          title: Text(widget.pageTitle, style: h4),
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
              title: Text('Home Page'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('My Profile'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('My Cart'),
              
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Store'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Add restaurant'),
              onTap: () {
                Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: AddResturant()));
              },
            ),
            ListTile(
              title: Text('Settings'),
              
              onTap: () {
                Navigator.pop(context);
                
              },
            ),
            ListTile(
              title: Text('Sign Out'),
              onTap: () {
                FirebaseAuth.instance.signOut().then((value){
                Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: HomePage()));
                }).catchError((e){print(e);});
              },
            ),
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
                          Text(widget.pageTitle, style: h3),
                          Text(widget.productprice.toString()+'EGP', style: h4),
                          Text('Ready in '+widget.timeToDone.toString()+' Minutes', style: h5),
                          // Container(
                          //   margin: EdgeInsets.only(top: 5, bottom: 20),
                          //   child: SmoothStarRating(
                          //     allowHalfRating: false,
                          //     onRatingChanged: (v) {
                          //       setState(() {
                          //         _rating = v;
                          //       });
                          //     },
                          //     starCount: 5,
                          //     rating: _rating,
                          //     size: 27.0,
                          //     color: Colors.orange,
                          //     borderColor: Colors.orange,
                          //   ),
                          // ),
                          Container(
                            margin: EdgeInsets.only(top: 10, bottom: 25),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Text('Quantity', style: h6),
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
                            child: froyoOutlineBtn('Buy Now', () {
                              Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.leftToRight, child: Buy(pageTitle: widget.pageTitle, product_quantity: _quantity, productPrice: widget.productprice, timeToDone: widget.timeToDone,)));
                            }),
                          ),
                          Container(
                            width: 180,
                            child: froyoFlatBtn('Add to Cart', () {
                              CartManagement().addCartItem(context, mealName:  widget.pageTitle, mealPrice: widget.productprice, timeToDone: widget.timeToDone, docID: id);
                            }),
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
                        child: Text('test'),
                        // foodItem(widget.productData,
                        //     isProductPage: true,
                        //     onTapped: () {},
                        //     imgWidth: 250,
                        //     onLike: () {}),
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
