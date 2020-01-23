import 'package:drive_thru/src/screens/AddResturant.dart';
import 'package:drive_thru/src/screens/HomePage.dart';
import 'package:drive_thru/src/screens/Timerpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
// import 'package:fryo/src/screens/UPP.dart' as prefix0;
import '../shared/styles.dart';
import '../shared/colors.dart';
import '../shared/fryo_icons.dart';
import './Menu.dart';
import '../shared/Product.dart';
import '../shared/partials.dart';
import './OldDashboard.dart';

List<Product> resturantsdata = [
  Product(
      name: "Pizza Hut",
      image: "images/ph.png",
      userLiked: false,
      discount: 10),
  Product(name: "KFC", image: "images/k.png", userLiked: false, discount: 7.8),
  Product(
    name: "Burger King",
    image: 'images/bk.png',
    userLiked: true,
  ),
  Product(
    name: "Papa JOhns",
    image: 'images/pj.png',
    userLiked: false,
  ),
  Product(
      name: "Macdonald", image: "images/m.png", userLiked: true, discount: 14)
];

class DashBoard extends StatefulWidget {
  final String pageTitle;

  DashBoard({Key key, this.pageTitle}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int _selectedIndex = 0;
  int _selectedcat = 1;
  @override
  Widget build(BuildContext context) {
    final _tabs = [
      storeTab(context),
      Text('Tab2'),
      Text('Tab3'),
      Text('Tab4'),
      Text('Tab5'),
    ];
    final _widgets = [reswidget(context), resturants(context),fastfood(context)];
    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: primaryColor,
          title:
              Text('Virtual DriveThru', style: logoWhiteStyle, textAlign: TextAlign.center),
              actions: <Widget>[
            FlatButton(

                onPressed: () {
                  Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: OldDashboard()));
                  },
                color: primaryColor,
                padding: EdgeInsets.all(2),
               shape: CircleBorder(),
                child: Icon(Icons.favorite, color: white, size: 25,),
            
            ),
              ],

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
              title: Text('Timer Page'),
              
              onTap: () {
                Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: TimerPage()));
                
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

            /*FlatButton(
                onPressed: () {
                    FirebaseAuth.instance.signOut().then((value){
                      Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: HomePage()));
                    }).catchError((e){print(e);});
                  },
                color: primaryColor,
                padding: EdgeInsets.all(2),
               shape: CircleBorder(),
                child: Icon(Icons.exit_to_app, color: white),
            )*/
            
          //],
    
        body: ListView(children: <Widget>[
          _tabs[_selectedIndex],
          _widgets[0],
          _widgets[_selectedcat]
        ]),
      
        );
  }

  
  void _onheadertappeed(int index) {
    setState(() {
      _selectedcat = index;
    });
  }

  Widget storeTab(BuildContext context) {
    // will pick it up from here
    // am to start another template


    List<Product> drinks = [
      Product(
          name: "Coca-Cola",
          image: "images/6.png",
          price: "\$45.12",
          userLiked: true,
          discount: 2),
      Product(
          name: "Lemonade",
          image: "images/7.png",
          price: "\$28.00",
          userLiked: false,
          discount: 5.2),
      Product(
          name: "Vodka",
          image: "images/8.png",
          // price: "\$78.99",
          userLiked: false),
      Product(
          name: "Tequila",
          image: "images/9.png",
          price: "\$168.99",
          userLiked: false,
          discount: 3.4)
    ];

    return Column(
      children: <Widget>[
        headerTopCategories(),
        // fastfood(context),
      ],
    );
  }

  Widget frieds(BuildContext context) {
    return headerTopCategories();
  }

  Widget sectionHeader(String headerTitle, {onViewMore}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 15, top: 10),
          child: Text(headerTitle, style: h4),
        ),
        Container(
          margin: EdgeInsets.only(left: 15, top: 2),
          child: FlatButton(
            onPressed: onViewMore,
            child: Text('View all ›', style: contrastText),
          ),
        )
      ],
    );
  }

// wrap the horizontal listview inside a sizedBox..
  Widget headerTopCategories() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        sectionHeader('All Categories', onViewMore: () {}),
        SizedBox(
          // width: MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.width,
          height: 130,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: <Widget>[
              headerCategoryItem('Frieds', Fryo.dinner, onPressed: () {
                setState(() {
                  _onheadertappeed(1);
                });
              }),
              headerCategoryItem('Fast Food', Fryo.food, onPressed: () {
                  setState(() {
                  _onheadertappeed(2);
                });
              }),
              headerCategoryItem('Creamery', Fryo.poop, onPressed: () {}),
              headerCategoryItem('Hot Drinks', Fryo.coffee_cup,
                  onPressed: () {}),
              headerCategoryItem('Vegetables', Fryo.leaf, onPressed: () {}),
            ],
          ),
        )
      ],
    );
  }

  Widget headerCategoryItem(String name, IconData icon, {onPressed}) {
    return Container(
      margin: EdgeInsets.only(left: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(bottom: 10),
              width: 86,
              height: 86,
              child: FloatingActionButton(
                shape: CircleBorder(),
                heroTag: name,
                onPressed: onPressed,
                backgroundColor: white,
                child: Icon(icon, size: 35, color: Colors.black87),
              )),
          Text(name + ' ›', style: categoryText)
        ],
      ),
    );
  }

  Widget reswidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(5),
              topEnd: Radius.circular(5),
              bottomStart: Radius.circular(5),
              topStart: Radius.circular(5))
       
          ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(bottom: 15),
              width: MediaQuery.of(context).size.width,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.only(right: 0, top: 2),
                        padding: const EdgeInsets.all(2),
                        height: 30,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle, color: Colors.white),
                        child: Center(
                            child: Text(
                          "Resturants",
                          style: TextStyle(
                            fontFamily: 'Pacifico',
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ))),
                  ])),
        ],
      ),
    );
  }

  Widget resturants(BuildContext context) {
    return Container(
        height: 400,
        padding: const EdgeInsets.all(5),
        child: ListView(children: <Widget>[
          Container(
              child: Column(children: <Widget>[
            resitem(resturantsdata[0], onTapped: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return new Menu(
                      productData: resturantsdata[0],
                    );
                  },
                ),
              );
            }, onLike: () {
              setState(() {
                (resturantsdata[0].userLiked)
                    ? resturantsdata[0].userLiked = false
                    : resturantsdata[0].userLiked = true;
              });
            }),
            resitem(resturantsdata[1], onTapped: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return new Menu(
                      productData: resturantsdata[1],
                    );
                  },
                ),
              );
            }, onLike: () {
              setState(() {
                (resturantsdata[1].userLiked)
                    ? resturantsdata[1].userLiked = false
                    : resturantsdata[1].userLiked = true;
              });
            }),
            resitem(resturantsdata[2], onTapped: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return new Menu(
                      productData: resturantsdata[2],
                    );
                  },
                ),
              );
            }, onLike: () {
              setState(() {
                (resturantsdata[2].userLiked)
                    ? resturantsdata[2].userLiked = false
                    : resturantsdata[2].userLiked = true;
              });
            }),
            resitem(resturantsdata[3], onTapped: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return new Menu(
                      productData: resturantsdata[3],
                    );
                  },
                ),
              );
            }, onLike: () {
              setState(() {
                (resturantsdata[3].userLiked)
                    ? resturantsdata[3].userLiked = false
                    : resturantsdata[3].userLiked = true;
              });
            }),
            resitem(resturantsdata[4], onTapped: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return new Menu(
                      productData: resturantsdata[4],
                    );
                  },
                ),
              );
            }, onLike: () {
              setState(() {
                (resturantsdata[4].userLiked)
                    ? resturantsdata[4].userLiked = false
                    : resturantsdata[4].userLiked = true;
              });
            })
          ]))
        ]));
  }





Widget fastfood(BuildContext context) {
    return Container(
        height: 400,
        padding: const EdgeInsets.all(5),
        child: ListView(children: <Widget>[
          Container(
              child: Column(children: <Widget>[
                foodItem(foods[0], onTapped: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return new Menu(
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
                                          return new Menu(
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
                                          return new Menu(
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
                                          return new Menu(
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


          ]))
        ]));
  }


}


