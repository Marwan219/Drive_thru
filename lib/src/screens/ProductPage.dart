import 'package:drive_thru/src/screens/survey.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../services/CartManagement.dart';
import '../shared/styles.dart';
import '../shared/colors.dart';
import '../shared/partials.dart';
import '../shared/buttons.dart';
import 'package:drive_thru/src/screens/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../shared/Product.dart';
import 'Buy.dart';

class ProductPage extends StatefulWidget {
  final String pageTitle;
  final double productprice;
  final int timeToDone;
  final String restID;
  final itemImageURL;

  ProductPage({Key key, this.pageTitle, this.productprice, this.timeToDone, this.restID, this.itemImageURL}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  double _rating = 4;
  int _quantity = 1;
  Order cartorder; 
  String id = '';

  void initState(){
  FirebaseAuth.instance.currentUser().then((user){
    setState(() {
      id = user.uid;
    });  
  }) ;
  }

  showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Virtual drive-thru'),
          content: Text("Are you sure to exit?"),
          actions: <Widget>[
            FlatButton(
              child: Text("Yes"),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        type: PageTransitionType.leftToRightWithFade,
                        child: HomePage()));
              },
            ),
            FlatButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
              child: Text('Timpo',
                  style: logoWhiteStyle, textAlign: TextAlign.center),
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
              title: Text('Map'),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) => new AlertDialog(
                        title: new Text("Comming soon"),
                        content: new Text("Timpo Map will be coming soon 🙂"),
                    )
                );}
            ),
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
            ListTile(
              title: Text('Sign Out'),
              onTap: () {
                FirebaseAuth.instance.signOut().then((value) {
                  showAlert(context);
                }).catchError((e) {
                  print(e);
                });
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
                            child: froyoFlatBtn('Add to Cart', () {
                              CartManagement().addCartItem( context,Order(mealname:widget.pageTitle,imageurl: widget.itemImageURL,price:widget.productprice,itemQuantity:_quantity,timeToDone:widget.timeToDone),widget.restID);
                              // CartManagement().addCartItem(context, mealName:  widget.pageTitle, mealPrice: widget.productprice, timeToDone: widget.timeToDone, docID: id, photoURL: widget.itemImageURL);
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
                        child: foodItem(widget.pageTitle,
                        imageURL: widget.itemImageURL,
                        price: widget.productprice,
                        
                        ),
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
