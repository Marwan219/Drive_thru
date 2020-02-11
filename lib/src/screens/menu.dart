import 'package:cloud_firestore/cloud_firestore.dart';
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

import 'AddMenue.dart';




class Menu extends StatefulWidget {
  final String pageTitle;
  final String imgURL;
  //final Product productData;
  final String resturantID;

  Menu({Key key, this.pageTitle,this.resturantID, this.imgURL}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  Firestore _firestore = Firestore.instance;
  List<DocumentSnapshot> _menuItems = [];
  bool isLoading = false;
  bool hasMore = true;
  int _viewCount = 2;
  DocumentSnapshot _lastDocument;
  ScrollController _scrollController = ScrollController();
  double _rating = 4;

  getProducts() async {  
   if (!hasMore) {  
     print('No More Products');  
     return;  
   }  
   if (isLoading) {  
     return;  
   }  
   setState(() {  
     isLoading = true;  
   });  
   QuerySnapshot querySnapshot;  
     querySnapshot = await _firestore
        .collection('/Restaurants').document(widget.resturantID).collection('Menu')
        .orderBy("Meal Name")
        .getDocuments(); 
    print(querySnapshot.documents[0].data);
   
   if (querySnapshot.documents.length < _viewCount) {  
     hasMore = false;  
   }    
   _menuItems.addAll(querySnapshot.documents);  
   setState(() {  
     isLoading = false;  
   });  
 }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_getResturants();
    getProducts();
  //   _scrollController.addListener(() {  
  //    double maxScroll = _scrollController.position.maxScrollExtent;  
  //    double currentScroll = _scrollController.position.pixels;  
  //    double delta = MediaQuery.of(context).size.height * 0.20;  
  //    if (maxScroll - currentScroll <= delta) {  
  //      setState(() {
  //         getProducts();
  //      });  
  //    }  
  //  });
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
          title: Text(widget.pageTitle, style: h4),
          actions: <Widget>[
            RaisedButton(child: Icon(Icons.control_point),onPressed:(){
              Navigator.push(context, MaterialPageRoute(builder: (context){return new AddMenue(docID: widget.resturantID ,); }));
            },
            color: bgColor,
            elevation: 0,
            )
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
        body: Column(children: [  
       Expanded(  
         child: _menuItems.length == 0  
             ? Center(  
                 child: Text('No Data...'),  
               )  
             : ListView.builder(  
                 controller: _scrollController,  
                 itemCount: _menuItems.length,  
                 itemBuilder: (context, index) {  
                   return ListTile(
                     title: Text(_menuItems[index].data['Meal Name']),
                     subtitle: Text('Takes About '+_menuItems[index].data['Time To Done'].toString()+' Minutes'),
                     trailing: Text(_menuItems[index].data['Meal Price'].toString()+ ' EGP'),
                     leading: Image.network(widget.imgURL),
                     onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ProductPage(
                                  pageTitle: _menuItems[index].data['Meal Name'],
                                  productprice: _menuItems[index].data['Meal Price'],
                                  timeToDone: _menuItems[index].data['Time To Done'],
                                );
                              },
                            ),
                          );
                        },
                     
                   );
                }  
               ),  
       ),  
       isLoading  
           ? Container(  
               width: MediaQuery.of(context).size.width,  
               padding: EdgeInsets.all(5),  
               color: Colors.yellowAccent,  
               child: Text(  
                 'Loading',  
                 textAlign: TextAlign.center,  
                 style: TextStyle(  
                   fontWeight: FontWeight.bold,  
                 ),  
               ),  
             )  
           : Container()  
     ]),  
//         ListView(

//             children: <Widget>[
//               Container(
//                   margin: const EdgeInsets.only(right: 0, top: 10),
//                   // color: Colors.amber[600],
//                   width: double.infinity,
//                   height: 280,
//                   decoration: rescardstyle, // for name of the restuarant

//                   child: Container(
//                     margin:
//                         const EdgeInsets.only(bottom: 15, top: 10, left: 10),
//                     // color: Colors.amber[600],
//                     width: MediaQuery.of(context).size.width,
//                     //  height: 100,
//                     decoration: brescardstyle, // for name of the restuarant
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: <Widget>[
//                         Container(
//                           // width: 300,
//                           // width: 200,
//                           margin: const EdgeInsets.only(top: 10),
//                           height: 200,
//                           decoration: BoxDecoration(
//                               shape: BoxShape.rectangle,
//                               borderRadius: BorderRadiusDirectional.only(
//                                   bottomStart: Radius.circular(10),
//                                   topStart: Radius.circular(10))
//                               //   BorderRadiusDirectional.only(
//                               //  bottomEnd: Radius.circular(20),topEnd:Radius.circular( 20)
//                               ,
//                               color: white),

//                           child:
//                               // Text("tset")
//                               Container(
//                                   width: MediaQuery.of(context).size.width * .5,
//                                   child: Image.asset(widget.productData.image)),
//                         ),
//                         Container(
//                             margin: const EdgeInsets.only(right: 5, top: 10),
//                             padding: const EdgeInsets.only(top: 60),
//                             height: 200,
//                             // width: double.infinity,
//                             decoration: BoxDecoration(
//                                 shape: BoxShape.rectangle,
//                                 borderRadius: BorderRadiusDirectional.only(
//                                     bottomEnd: Radius.circular(10),
//                                     topEnd: Radius.circular(10))
//                                 //   BorderRadiusDirectional.only(
//                                 //  bottomEnd: Radius.circular(20),topEnd:Radius.circular( 20)
//                                 ,
//                                 color: white),
//                             child: Column(
//                               children: <Widget>[
//                                 Text(
//                                   widget.productData.name,
//                                   style: h3,
//                                 ),
//                                 Container(
//                                   // width: double.infinity,
//                                   margin: EdgeInsets.only(top: 5, bottom: 20),
//                                   child: SmoothStarRating(
//                                     allowHalfRating: false,
//                                     onRatingChanged: (v) {
//                                       setState(() {
//                                         _rating = v;
//                                       });
//                                     },
//                                     starCount: 5,
//                                     rating: _rating,
//                                     size: 27.0,
//                                     color: Colors.orange,
//                                     borderColor: Colors.orange,
//                                   ),
//                                 ),
//                               ],
//                             ))
//                       ],
//                     ),
//                   )),

          
//                     Container(
//                        margin: const EdgeInsets.only(right: 10, top: 10,left: 10),
//                             padding: const EdgeInsets.only(top: 5),
//                        decoration:BoxDecoration ( 
//                             shape:BoxShape.rectangle ,
//                             color: Colors.white,

//                              borderRadius:BorderRadiusDirectional.only(bottomEnd:Radius.circular(10),topEnd:Radius.circular(10),bottomStart:Radius.circular(10),topStart:Radius.circular(10) )
//                             //   BorderRadiusDirectional.only(
//                             //  bottomEnd: Radius.circular(20),topEnd:Radius.circular( 20)
//                             //   ,
//                             // color: Colors.white),
//                        ),
//                         child:Center(child: Text(
//                       "Menu",
//                       style: TextStyle(
//                         //  fontFamily: 'Pacifico',
//                         fontSize: 16,
//                         color: Colors.black,
//                       ),
//                     ))),
                    
//                                   foodItem(foods[0], onTapped: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) {
//                                           return new ProductPage(
//                                             productData: foods[0],
//                                           );
//                                         },
//                                       ),
//                                     );
//                                   }, onLike: () {
//                                     setState(() {
//                                       (foods[0].userLiked)?foods[0].userLiked=false: foods[0].userLiked=true;
//                                     });
//                                   }),
//                                   foodItem(foods[1], onTapped: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) {
//                                           return new ProductPage(
//                                             productData: foods[1],
//                                           );
//                                         },
//                                       ),
//                                     );
//                                   }, onLike: () {
//                                     setState(() {
//                                       (foods[1].userLiked)?foods[1].userLiked=false: foods[1].userLiked=true;
//                                     });
//                                   }),
//                                   foodItem(foods[2], onTapped: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) {
//                                           return new ProductPage(
//                                             productData: foods[2],
//                                           );
//                                         },
//                                       ),
//                                     );
//                                   }, onLike: () {
//                                      setState(() {
//                                       (foods[2].userLiked)?foods[2].userLiked=false: foods[2].userLiked=true;
//                                     });
//                                   }),
//                                 foodItem(foods[3], onTapped: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) {
//                                           return new ProductPage(
//                                             productData: foods[2],
//                                           );
//                                         },
//                                       ),
//                                     );
//                                   }, onLike: () {
//                                     setState(() {
//                                       (foods[3].userLiked)?foods[3].userLiked=false: foods[3].userLiked=true;
//                                     });
//                                   })


//                           ],
                        
                 
//             )
//         // )])
//         );
//   }
    );}
}