import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drive_thru/root.dart';
import 'package:drive_thru/src/screens/Orders.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../shared/styles.dart';
import '../shared/colors.dart';
import 'ProductPage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Orders extends StatefulWidget{
   final String uid;
  final String resturantID;
  Orders({Key key, this.uid, this.resturantID}) : super(key: key);
  @override
  _OrdersState createState() => _OrdersState();
}
class _OrdersState extends State<Orders>{
  @override

  Firestore _firestore = Firestore.instance;
  List<DocumentSnapshot> _cartItems = [];
  bool isLoading = false;
  bool hasMore = true;
  int _viewCount = 2;
  double _rating = 4;
  double total = 0;

  getCartTotal(List cartlist){
    double total = 0;
    for (int i=0; cartlist.length>i;i++ ){
      total = total +cartlist[i].data['Meal Price'];
    }
    return total;
  }

  deleteCartItem(int index) async {
    final docRef = await _firestore.collection('/users')
                                    .document(widget.uid)
                                    .collection('Cart')
                                    .document(_cartItems[index].documentID)
                                    .delete().then((v){print('deleted');
                                    _cartItems.removeAt(index);
                                    });
    setState(() {
      total = getCartTotal(_cartItems);
    });
  }

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
        .collection('/users').document(uID).collection('Cart')
        .orderBy("Meal Name")
        .getDocuments(); 
    print(querySnapshot.documents[0].data['Item Image URL']);
   
   if (querySnapshot.documents.length < _viewCount) {  
     hasMore = false;  
   }    
   _cartItems.addAll(querySnapshot.documents);  
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
    total = getCartTotal(_cartItems);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: bgColor,
        appBar: new AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: primaryColor,
          title:
              Text('Your Order', style: logoWhiteStyle, textAlign: TextAlign.center),
              // actions: <Widget>[
              //   new
              // ],
        ),
        body: Column(children: [  
       Expanded(  
         child: _cartItems.length == 0  
             ? Center(  
                 child:  SpinKitThreeBounce(
                color: Colors.orange,
               size: 20.0,
                ),
               )  
             : ListView.builder(    
                 itemCount: _cartItems.length,  
                 itemBuilder: (context, index) {  
                   return ListTile(
                     leading: IconButton( icon:Icon(Icons.clear), onPressed: () => deleteCartItem(index),),
                     title: Text(_cartItems[index].data['Meal Name']),
                     subtitle: Text('Takes About '+_cartItems[index].data['Time To Done'].toString()+' Minutes'),
                     trailing: Text(_cartItems[index].data['Meal Price'].toString()+ ' EGP'),
                     onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ProductPage(
                                  itemImageURL: _cartItems[index].data['Item Image URL'],
                                  pageTitle: _cartItems[index].data['Meal Name'],
                                  productprice: _cartItems[index].data['Meal Price'],
                                  timeToDone: _cartItems[index].data['Time To Done'],
                                  restID: widget.resturantID,
                                );
                              },
                            ),
                          );
                        },
                     
                   );
                }  
               ),  
       ),  
      //  isLoading  
      //      ? Container(  
      //         child: SpinKitThreeBounce(
      //           color: Colors.orange,
      //          size: 20.0,
      //           ),
              //  width: MediaQuery.of(context).size.width,  
              //  padding: EdgeInsets.all(5),  
              //  color: Colors.yellowAccent,  
              //  child: Text(  
              //    'Loading',  
              //    textAlign: TextAlign.center,  
              //    style: TextStyle(  
              //      fontWeight: FontWeight.bold,  
              //    ),  
              //  ),  
          //    )  
          //  :
            Container()  
     ]));  
  }


}