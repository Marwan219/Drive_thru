import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drive_thru/src/screens/Buy.dart';
import 'package:drive_thru/src/screens/Orders.dart';
import 'package:drive_thru/src/shared/partials.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../shared/styles.dart';
import '../shared/colors.dart';
import 'ProductPage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../shared/Product.dart';

class Carts extends StatefulWidget {
  List<Order> orders = [];
  final String uid;
  final String resturantID;
  Carts({Key key, this.uid, this.resturantID}) : super(key: key);
  @override
  _CartsState createState() => _CartsState();
}

class _CartsState extends State<Carts> {
  Firestore _firestore = Firestore.instance;
  List<DocumentSnapshot> _cartItems = [];
  bool isLoading = false;
  bool hasMore = true;
  int _viewCount = 2;
  double _rating = 4;
  double total = 0;

  List getCartTotal(List cartlist) {
    double totalprice = 0;
    int totalitems =0;
    for (int i = 0; cartlist.length > i; i++) {
      print(cartlist[i].data['Meal Price']);
      totalprice = totalprice + (cartlist[i].data['Meal Price']*cartlist[i].data['Quantity']);
      totalitems = totalitems +cartlist[i].data['Quantity'];
    }
    // add order total price

    return [totalprice,totalitems];
  }

  deleteCartItem(int index) async {
    final docRef = await _firestore
        .collection('/users')
        .document(widget.uid)
        .collection('Cart')
        .document(_cartItems[index].documentID)
        .delete()
        .then((v) {
      print('deleted');
      _cartItems.removeAt(index);
    });
    setState(() {
      total = getCartTotal(_cartItems)[0];
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
        .collection('/users')
        .document(widget.uid)
        .collection('Cart')
        .orderBy("Meal Name")
        .getDocuments();

    if (querySnapshot.documents.length < _viewCount) {
      hasMore = false;
    }
    //  widget.orderdetails.price=200.0;
    _cartItems.addAll(querySnapshot.documents);
    // add all items of the cart to the order
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
    total = getCartTotal(_cartItems)[0];
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
        title: Text('Cart', style: logoWhiteStyle, textAlign: TextAlign.center),
        // actions: <Widget>[
        //   new
        // ],
      ),
      body: Column(children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Spacer(
              flex: 4,
            ),
            Text(
              "Items",
              style: h4,
            ),
            Spacer(
              flex: 4,
            ),
            Text(
              "Quantiy",
              style: h4,
            ),
            Spacer(
              flex: 1,
            ),
            Text(
              "Price",
              style: h4,
            ),
            Spacer(
              flex: 1,
            ),
          ],
        ),
        Expanded(
          child: _cartItems.length == 0
              ? Center(
                  child: Text('Your Carts Is Empty!'),
                )
              : ListView.builder(
                  itemCount: _cartItems.length,
                  itemBuilder: (context, index) {
                    return
                        //  restime3(price: 1,food: "sad",quantity: 22);
                        ListTile(
                      leading: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () => deleteCartItem(index),
                      ),
                      title: Text(_cartItems[index].data['Meal Name']),
                      subtitle: Text('Takes About ' + _cartItems[index].data['Time To Done'].toString() + ' Minutes'),
                      trailing: Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Divider(),
                            Text(_cartItems[index].data['Quantity'].toString()),
                            Spacer(
                              flex: 1,
                            ),
                            Text(double.parse((_cartItems[index].data['Meal Price']*_cartItems[index].data['Quantity']).toStringAsFixed(3).toString()).toStringAsFixed(2)+' EGP'),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ProductPage(
                                itemImageURL:
                                    _cartItems[index].data['Item Image URL'],
                                pageTitle: _cartItems[index].data['Meal Name'],
                                productprice:
                                    _cartItems[index].data['Meal Price'],
                                timeToDone:
                                    _cartItems[index].data['Time To Done'],
                                restID: widget.resturantID,
                              );
                            },
                          ),
                        );
                      },
                    );
                  }),
        ),
        //  isLoading
        //  ? Container(
        //     child: SpinKitThreeBounce(
        //       color: Colors.orange,
        //      size: 20.0,
        //       ),
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
        //  )
        //  :
        Container()
      ]),
      bottomNavigationBar: new Container(
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(
                    left: 15,
                  ),
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    ("Total: ${getCartTotal(_cartItems)[0].toStringAsFixed(2)}"),
                    style: TextStyle(fontSize: 20),
                  )),
              Expanded(
                child: new MaterialButton(
                  onPressed: () {
                    _cartItems.map((value) {
                      widget.orders.add(Order(
                          mealname: value.data["Meal Name"],
                          resturantid: widget.resturantID.toString(),
                          price: value.data['Meal Price'],
                          date: value.data['Time To Done'].toString(),
                          itemQuantity: value.data['Quantity']));
                    }).toList();
                    double carttotal = getCartTotal(_cartItems)[0];
                    int totalitems=getCartTotal(_cartItems)[1];
                    if (_cartItems.length>0){
                       Navigator.pushReplacement(context,PageTransition(type: PageTransitionType.leftToRight,child: Buy(buyorders: widget.orders,cartTotal:carttotal,resturantID:widget.resturantID,totalitems:totalitems ,)));
                    }
                    else  { 

                    }
                    // print(widget.orders[0].date);
                   
                  },
                  child: new Text("Check Out",
                      style: TextStyle(color: Colors.black)),
                  color: Colors.red,
                ),
              )
            ],
          )),
    );
  }
}
