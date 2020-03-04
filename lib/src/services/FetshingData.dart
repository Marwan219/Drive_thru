// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:drive_thru/src/screens/Dashboard.dart';
// import 'package:drive_thru/src/screens/menu.dart';
// import 'package:drive_thru/src/shared/colors.dart';
// import 'package:drive_thru/src/shared/partials.dart';
// import 'package:flutter/material.dart';
// import 'package:page_transition/page_transition.dart';


// class FetshingData extends StatefulWidget {
  
  
//   @override
//   _FetshingDataState createState() => _FetshingDataState();
// }

// class _FetshingDataState extends State<FetshingData> {
//   Firestore _firestore = Firestore.instance;
//   List<DocumentSnapshot> _resturants = [];
//   bool isLoading = false;
//   bool hasMore = true;
//   int _viewCount = 10;
//   DocumentSnapshot _lastDocument;
//   ScrollController _scrollController = ScrollController();
  
//   // _getResturants() async{
//   //   Query q = _firestore.collection('Orders').orderBy("Item Name").limit(_viewCount);

//   //   QuerySnapshot querySnapshot = await q.getDocuments();
//   //   _lastDocument = querySnapshot.documents[querySnapshot.documents.length-1];
//   //   _resturants = querySnapshot.documents;
//   //   print(querySnapshot.documents);
//   // }

//   // _getMoreResturents() async{
//   //   QuerySnapshot querySnapshot;
//   //   print('#############################################');
//   //   Query q = _firestore
//   //     .collection('Orders')
//   //     .orderBy("Item Name")
//   //     .startAfterDocument(_lastDocument)
//   //     .limit(_viewCount);

//   //   querySnapshot = await q.getDocuments();
//   //   _resturants.addAll(querySnapshot.documents);
//   // }

  

//   getProducts() async {  
//    if (!hasMore) {  
//      print('No More Products');  
//      return;  
//    }  
//    if (isLoading) {  
//      return;  
//    }  
//    setState(() {  
//      isLoading = true;  
//    });  
//    QuerySnapshot querySnapshot;  
//    if (_lastDocument == null) {  
//      querySnapshot = await _firestore
//         .collection('Restaurants')
//         .orderBy("Resturant Name")
//         .limit(_viewCount).
//         getDocuments(); 
//         print(querySnapshot.documents[0].data['Resturant Name']);
//         print(querySnapshot.documents[0].data['imageURL']);
//    } else {  
//      querySnapshot = await _firestore
//         .collection('Restaurants')
//         .orderBy("Resturant Name")
//          .startAfterDocument(_lastDocument)  
//         .limit(_viewCount)
//         .getDocuments();  
//      print('#########################');  
//    }  
//    if (querySnapshot.documents.length < _viewCount) {  
//      hasMore = false;  
//    }  
//    _lastDocument = querySnapshot.documents[querySnapshot.documents.length - 1];  
//    _resturants.addAll(querySnapshot.documents);  
//    setState(() {  
//      isLoading = false;  
//    });  
//  }

// @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     //_getResturants();
//     getProducts();
//     _scrollController.addListener(() {  
//      double maxScroll = _scrollController.position.maxScrollExtent;  
//      double currentScroll = _scrollController.position.pixels;  
//      double delta = MediaQuery.of(context).size.height * 0.20;  
//      if (maxScroll - currentScroll <= delta) {  
//        setState(() {
//           getProducts();
//        });  
//      }  
//    });
//   }


// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Resturants'),
// //         centerTitle: true,
// //         leading: BackButton(color: darkText,onPressed:(){ Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.leftToRight, child:DashBoard()));},)
// //       ),
// //       body: Container(
// //         child: _resturants.length == 0
// //           ? Center(
// //             child: Text('No Resturents yet'),
// //           ) 
// //           : ListView.builder(
// //             controller: _scrollController,
// //             itemCount: _resturants.length,
// //             itemBuilder: (BuildContext context, int index){
// //               return ListTile(
// //                 title: Text(_resturants[index].data['Item Name']),
// //                 subtitle: Text(index.toString()),
// //               );
// //           },),
// //       ),
// //     );
// //   }
// // }

// @override  
//  Widget build(BuildContext context) {  
//    return Scaffold(  
//      appBar: AppBar(  
//        title: Text('Resturants'),
//        //leading: BackButton(color: darkText,onPressed:(){ Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.leftToRight, child:DashBoard()));},)  
//      ),  
//      body: Column(children: [  
//        Expanded(  
//          child: _resturants.length == 0  
//              ? Center(  
//                  child: Text('No Data...'),  
//                )  
//              : ListView.builder(  
//                  controller: _scrollController,  
//                  itemCount: _resturants.length,  
//                  itemBuilder: (context, index) {  
//                    return resitem2(
//                      _resturants[index].data['Resturant Name'],
//                      onTapped: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) {
//                             return new Menu(
//                               pageTitle: _resturants[index].data['Resturant Name'] ,
//                               resturantID: _resturants[index].documentID,
//                               imgURL: _resturants[index].data['imageURL'],
//                             );
//                           },
//                         ),
//                       );
//                     },imgURL: _resturants[index].data['imageURL']
//                    );
//                  },  
//                ),  
//        ),  
//        isLoading  
//            ? Container(  
//                width: MediaQuery.of(context).size.width,  
//                padding: EdgeInsets.all(5),  
//                color: Colors.yellowAccent,  
//                child: Text(  
//                  'Loading',  
//                  textAlign: TextAlign.center,  
//                  style: TextStyle(  
//                    fontWeight: FontWeight.bold,  
//                  ),  
//                ),  
//              )  
//            : Container()  
//      ]),  
//    );  
//  }
// }