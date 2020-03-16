import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drive_thru/src/shared/partials.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import './Timerpage.dart';
import '../shared/styles.dart';
import '../shared/colors.dart';


class Report extends StatefulWidget{
  
  @override

  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report>{
  var list=5;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Report"),
      ),
      body: Column(
            children: <Widget>[
              
              Container(
              
             
              child: Column(children: <Widget>[
                Text(
                  " Bill ",
                  style: h3,
                ),
                Text(
                  " 3/4/2019 ",
                  style: h3,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      " Items",
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
                    )
                  ],
                ),
                Divider(),
                ])),
                Container(
                 
                  
                  child:Expanded(child:
                  ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context,index){
                    return restime3(food: " Mac chicken",price: 30,quantity: 6);

                    

                  },
                )
                      
                    )
                   
                    ),
                
                 
                
               
                Divider(),
                Container(
                  margin: EdgeInsets.only(top: 1, bottom: 2),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Total price",
                          style: h5,
                        ),
                        Spacer(
                          flex: 5,
                        ),
                        Text("151",style:h5)
                        
                      ],
                    )),
              
                
              ],
              ),
              );
            


  }




}

