import 'package:flutter/material.dart';
import '../shared/Product.dart';
import '../shared/styles.dart';
import '../shared/colors.dart';
import '../shared/partials.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import './ProductPage.dart';
import 'package:drive_thru/src/screens/AddResturant.dart';
import 'package:drive_thru/src/screens/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:page_transition/page_transition.dart';
import '../../generated/intl/l10n.dart';
import '../../generated/intl/helper.dart';
import '../services/flutter_restart.dart';
import 'package:drive_thru/src/screens/Timerpage.dart';
import 'package:drive_thru/src/services/FetshingData.dart';
import '../shared/language_change.dart';

List<Product> foods = [
  Product(
      name: "Hamburger",
      image: "images/3.png",
      price: "\$25.00",
      userLiked: false,
      discount: 10),
  Product(
      name: "Pasta",
      image: "images/5.png",
      price: "\$150.00",
      userLiked: false,
      discount: 7.8),
  Product(
    name: "Akara",
    image: 'images/2.png',
    price: '\$10.99',
    userLiked: false,
  ),
  Product(
      name: "Macdonald",
      image: "images/1.png",
      price: '\$50.00',
      userLiked: false,
      discount: 14)
];



class Menu extends StatefulWidget {
  final String pageTitle;
  final Product productData;

  Menu({Key key, this.pageTitle, this.productData}) : super(key: key);
 
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {

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
  double _rating = 4;
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
                  margin: const EdgeInsets.only(right: 0, top: 10),
                  // color: Colors.amber[600],
                  width: double.infinity,
                  height: 280,
                  decoration: rescardstyle, // for name of the restuarant

                  child: Container(
                    margin:
                        const EdgeInsets.only(bottom: 15, top: 10, left: 10),
                    // color: Colors.amber[600],
                    width: MediaQuery.of(context).size.width,
                    //  height: 100,
                    decoration: brescardstyle, // for name of the restuarant
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          // width: 300,
                          // width: 200,
                          margin: const EdgeInsets.only(top: 10),
                          height: 200,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadiusDirectional.only(
                                  bottomStart: Radius.circular(10),
                                  topStart: Radius.circular(10))
                              //   BorderRadiusDirectional.only(
                              //  bottomEnd: Radius.circular(20),topEnd:Radius.circular( 20)
                              ,
                              color: white),

                          child:
                              // Text("tset")
                              Container(
                                  width: MediaQuery.of(context).size.width * .5,
                                  child: Image.asset(widget.productData.image)),
                        ),
                        Container(
                            margin: const EdgeInsets.only(right: 5, top: 10),
                            padding: const EdgeInsets.only(top: 60),
                            height: 200,
                            // width: double.infinity,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadiusDirectional.only(
                                    bottomEnd: Radius.circular(10),
                                    topEnd: Radius.circular(10))
                                //   BorderRadiusDirectional.only(
                                //  bottomEnd: Radius.circular(20),topEnd:Radius.circular( 20)
                                ,
                                color: white),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  widget.productData.name,
                                  style: h3,
                                ),
                                Container(
                                  // width: double.infinity,
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
                              ],
                            ))
                      ],
                    ),
                  )),

          
                    Container(
                       margin: const EdgeInsets.only(right: 10, top: 10,left: 10),
                            padding: const EdgeInsets.only(top: 5),
                       decoration:BoxDecoration ( 
                            shape:BoxShape.rectangle ,
                            color: Colors.white,

                             borderRadius:BorderRadiusDirectional.only(bottomEnd:Radius.circular(10),topEnd:Radius.circular(10),bottomStart:Radius.circular(10),topStart:Radius.circular(10) )
                            //   BorderRadiusDirectional.only(
                            //  bottomEnd: Radius.circular(20),topEnd:Radius.circular( 20)
                            //   ,
                            // color: Colors.white),
                       ),
                        child:Center(child: Text(
                      AppLocalizations.of(context).menutxt,
                      style: TextStyle(
                        //  fontFamily: 'Pacifico',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ))),
                    
                                  foodItem(foods[0], onTapped: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return new ProductPage(
                                            productData: foods[0],
                                          );
                                        },
                                      ),
                                    );
                                  }, onLike: () {
                                    setState(() {
                                      (foods[0].userLiked)?foods[0].userLiked=false: foods[0].userLiked=true;
                                    });
                                  }),
                                  foodItem(foods[1], onTapped: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return new ProductPage(
                                            productData: foods[1],
                                          );
                                        },
                                      ),
                                    );
                                  }, onLike: () {
                                    setState(() {
                                      (foods[1].userLiked)?foods[1].userLiked=false: foods[1].userLiked=true;
                                    });
                                  }),
                                  foodItem(foods[2], onTapped: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return new ProductPage(
                                            productData: foods[2],
                                          );
                                        },
                                      ),
                                    );
                                  }, onLike: () {
                                     setState(() {
                                      (foods[2].userLiked)?foods[2].userLiked=false: foods[2].userLiked=true;
                                    });
                                  }),
                                foodItem(foods[3], onTapped: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return new ProductPage(
                                            productData: foods[2],
                                          );
                                        },
                                      ),
                                    );
                                  }, onLike: () {
                                    setState(() {
                                      (foods[3].userLiked)?foods[3].userLiked=false: foods[3].userLiked=true;
                                    });
                                  })


                          ],
                        
                 
            )
        // )])
        );
  }
}
