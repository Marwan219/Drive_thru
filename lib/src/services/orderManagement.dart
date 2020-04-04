//to do 
/// 
/// 1- class for orderign system
///   - function for ordering the food from the first app (user) to the database 
///   - function to confirm that the order is accepted from the resturant 
///   - function that order is ready 
///    

import '../../src/shared/Product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import  '../../root.dart';
import '../shared/Neworder.dart';
    

class OrderManagement { 
// start of the class 
 
// // function to order the food
//   ordering({List<Order> order,total}) async{ 
//     // {mealName, mealPrice, timeToDone, docID, photoURL
//       var now = new DateTime.now();
//       var date = "${now.day}_${now.month}_${now.year}";
//       var hour = "${now.hour}:${now.minute}";
//       var totalitems=0;
      
//        order.map((value){
//             totalitems +=value.itemQuantity;
//             Firestore.instance.collection('/users').document(uID).collection('Orders').document(date).collection("orders").document(hour).collection("Meals").document(value.mealname).setData({
//               "Quantity":value.itemQuantity,
//               "Details":value.deliveryDetails,
//             });
//         }).toList();
//     final docRef = await Firestore.instance.collection('/users').document(uID).collection('Order').document(date).collection("orders").document(hour).setData({
//       'Total Items': totalitems,
//       'Total Price': total,
//       "status":"requested"
//     });
  
//     }

// resturantOrdeering({List<Order> order,total,restid,List userdata}) async{ 
//       var now = new DateTime.now();
//       var date = "${now.day}_${now.month}_${now.year}";
//       var hour = "${now.hour}:${now.minute}";
//       var totalitems=0;
       
       
//        print(restid);
//        print(userdata);
      // print();       

    //    order.map((value)async{
    //        totalitems +=value.itemQuantity;
    //         print(totalitems);
    //          final resdoc = await Firestore.instance.collection('/Restaurants').document(restid).collection('Orders').document(date).collection("Dayorders").document(hour+"_${uID.substring(0,5)}").collection("Meals").document(value.mealname).setData({
    //           "Quantity":value.itemQuantity,
    //           "Details":value.deliveryDetails,
    //         });
    //     }).toList();
    
    // final docRef = await Firestore.instance.collection('/Restaurants').document(restid).collection('Orders').document(date).collection("Dayorders").document(hour+"_${uID.substring(0,5)}").setData({
    //   'Total Items': totalitems,
    //   'Total Price': total,
    //   "status":"requested",
    //   "Phone Number":userdata[1]["w_Phone Number"],
    //   "Client":userdata[1]["w_Name"]
    // });}
        
    ordering({ Neworder order,total}) async{ 
        // {mealName, mealPrice, timeToDone, docID, photoURL
          var now = new DateTime.now();
          var date = "${now.day}_${now.month}_${now.year}_${now.hour}:${now.minute}-${uID.substring(0,4)}";
          
                await Firestore.instance.collection('/users').document(uID).collection('Orders').document().setData({
                "Meals" : order.meals,
                "Address":order.address,
                "Date":date, 
                "Items":order.totalOrderItems,
                "Price":order.price,
                "Status":order.status
                });
           
     
        }
  
    

resturantOrdeering({Neworder order,total,restid}) async{ 
      var now = new DateTime.now();

      var date = "${now.day}_${now.month}_${now.year}_${now.hour}:${now.minute}-${uID.substring(0,4)}";
    
       
      await Firestore.instance.collection('/Restaurants').document(restid).collection('Orders').document().setData({
                "Meals" : order.meals,
                "Address":order.address,
                "Client":order.client,
                "Date":date,
                "Items":order.totalOrderItems,
                "Price":order.price,
                "Status":order.status,
                "get_product":false
                });
       
  
    



// end of the class   
}
}