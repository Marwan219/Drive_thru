
import 'package:drive_thru/src/screens/NewDashboard.dart';

class Neworder { 


  final List<Map> meals; 
  // final DateTime date; 
  final int totalOrderItems; 
  final Map client;
  final double price;
  final String address; 
  final String status;
  Neworder({
    this.status,
    this.price,
    this.address,
    this.client,
    // this.date,
    this.meals,
    this.totalOrderItems
  });

}