import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drive_thru/src/screens/menu.dart';
import 'package:drive_thru/src/shared/partials.dart';
import 'package:flutter/material.dart';
import 'package:drive_thru/src/screens/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:page_transition/page_transition.dart';
import '../shared/styles.dart';
import '../shared/colors.dart';
import '../shared/partials.dart';
import 'package:drive_thru/src/shared/colors.dart';
import './Carts.dart';
import './survey.dart';
//import './popup.dart';

class NewDashboard extends StatefulWidget {
  final String userID;
  NewDashboard({Key key, this.userID}) : super(key: key);
  @override
  _NewDashboardState createState() => _NewDashboardState();
}

class _NewDashboardState extends State<NewDashboard> {
  Firestore _firestore = Firestore.instance;
  List<DocumentSnapshot> _resturants = [];
  bool isLoading = false;
  bool hasMore = true;
  int _viewCount = 5;
  DocumentSnapshot _lastDocument;
  ScrollController _scrollController = ScrollController();
  
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
   if (_lastDocument == null) {  
     querySnapshot = await _firestore
        .collection('Restaurants')
        .orderBy("Resturant Name")
        .limit(_viewCount).
        getDocuments(); 
   } else {  
     querySnapshot = await _firestore
        .collection('Restaurants')
        .orderBy("Resturant Name")
         .startAfterDocument(_lastDocument)  
        .limit(_viewCount)
        .getDocuments();  
     print('#########################');  
   }  
   if (querySnapshot.documents.length < _viewCount) {  
     hasMore = false;  
   }  
   _lastDocument = querySnapshot.documents[querySnapshot.documents.length - 1];  
   _resturants.addAll(querySnapshot.documents);  
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
    _scrollController.addListener(() {  
     double maxScroll = _scrollController.position.maxScrollExtent;  
     double currentScroll = _scrollController.position.pixels;  
     double delta = MediaQuery.of(context).size.height * 0.20;  
     if (maxScroll - currentScroll <= delta) {  
       setState(() {
          getProducts();
       });  
     }  
   });
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
                Navigator.of(context).pop();
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
     appBar: AppBar(  
       centerTitle: true,
          elevation: 0,
          backgroundColor: primaryColor,
          title:
              Text('Timpo', style: logoWhiteStyle, textAlign: TextAlign.center),
              actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.push(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: Carts(uid: widget.userID,)));
                  },
                color: primaryColor,
                padding: EdgeInsets.all(2),
               shape: CircleBorder(),
                child: Icon(Icons.shopping_cart, color: white, size: 25,),
            
            ),
              ],
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
              title: Text('My Cart'),
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.leftToRightWithFade,
                        child: Carts(uid: widget.userID,)));
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
     body: 
      Column(children: [  
       Expanded(  
         child: _resturants.length == 0  
             ? Center(  
                 child: Text('No Data...'),  
               )  
             : ListView.builder(
                 controller: _scrollController,  
                 itemCount: _resturants.length,  
                 itemBuilder: (context, index) {  
                   return resitem2(
                     _resturants[index].data['Resturant Name'],
                     onTapped: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Menu(
                              pageTitle: _resturants[index].data['Resturant Name'],
                              resturantID: _resturants[index].documentID,
                              imgURL: _resturants[index].data['imageURL'],
                            );
                          },
                        ),
                      );
                    },imgURL: _resturants[index].data['imageURL'],
                    context: context,
                   );
                 },  
               ), 
       ),  
       isLoading  
           ? Container(  
               width: MediaQuery.of(context).size.width,  
               padding: EdgeInsets.all(5),  
               color: Colors.orangeAccent,  
               child: Text(  
                 'Loading',  
                 textAlign: TextAlign.center,  
                 style: TextStyle(  
                   fontWeight: FontWeight.bold,  
                 ),  
               ),  
             )  
             
             
           : Container(
             
           )  
           
     ]
    ),  
   ); 
 }
}