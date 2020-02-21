import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drive_thru/src/screens/survey.dart';
import 'package:flutter/material.dart';
import '../shared/styles.dart';
import '../shared/colors.dart';
import './ProductPage.dart';
import 'package:drive_thru/src/screens/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:page_transition/page_transition.dart';




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
    getProducts();
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
          // actions: <Widget>[
          //   RaisedButton(child: Icon(Icons.control_point),onPressed:(){
          //     Navigator.push(context, MaterialPageRoute(builder: (context){return new AddMenue(docID: widget.resturantID ,); }));
          //   },
          //   color: bgColor,
          //   elevation: 0,
          //   )
          // ],
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
                     leading: CircleAvatar(radius: 30.0, backgroundImage: NetworkImage(_menuItems[index].data['Item Image URL']),),
                     onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ProductPage(
                                  pageTitle: _menuItems[index].data['Meal Name'],
                                  productprice: _menuItems[index].data['Meal Price'],
                                  timeToDone: _menuItems[index].data['Time To Done'],
                                  restID: widget.resturantID,
                                  itemImageURL: _menuItems[index].data['Item Image URL'],
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
    );}
}