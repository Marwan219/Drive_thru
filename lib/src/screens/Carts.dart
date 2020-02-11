import 'package:flutter/material.dart';
import '../shared/styles.dart';
import '../shared/colors.dart';
import '../shared/fryo_icons.dart';

class Carts extends StatefulWidget{
  @override
  _CartsState createState() => _CartsState();
}
class _CartsState extends State<Carts>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: bgColor,
        appBar: new AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: primaryColor,
          title:
              Text('Cart', style: logoWhiteStyle, textAlign: TextAlign.center),
              // actions: <Widget>[
              //   new
              // ],
        ),
        bottomNavigationBar: new Container(
          color: Colors.white,
          child: Row(children: <Widget>[
            Expanded(child: ListTile(title: new Text("Total:"),
            subtitle: new Text("\$20"),
            ),),
            Expanded(child: new MaterialButton(onPressed:(){},
            child: new Text("Check Out", style: TextStyle(color: Colors.white)),
           color: Colors.red, ),
            )
          ],)
        ),
    );
  }


}