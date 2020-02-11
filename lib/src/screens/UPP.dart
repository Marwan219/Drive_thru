import 'package:flutter/material.dart';
import '../shared/Product.dart';
import '../shared/styles.dart';
import '../shared/colors.dart';
import '../shared/partials.dart';
import '../shared/buttons.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import './menu.dart';
import './ProductPage.dart';
import 'AddMenue.dart';

List<Product> foods = [
  Product(
      name: "Hamburger",
      image: "images/3.png",
      time: 10,
      price: "\$25.00",
      userLiked: false,
      discount: 10),
  Product(
      name: "Pasta",
      image: "images/5.png",
      time: 22,
      price: "\$150.00",
      userLiked: false,
      discount: 7.8),
  Product(
    name: "Akara",
    image: 'images/2.png',
    time: 15,
    price: '\$10.99',
    userLiked: false,
  ),
  Product(
      name: "Macdonald",
      image: "images/1.png",
      price: '\$50.00',
      userLiked: false,
      discount: 14)
];

class UPP extends StatefulWidget {
  final String pageTitle;
  final Product productData;

  UPP({Key key, this.pageTitle, this.productData}) : super(key: key);

  @override
  _UPPState createState() => _UPPState();
}

class _UPPState extends State<UPP> {
  double _rating = 4;
  int _quantity = 1;
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
          title: Text(widget.productData.name, style: h4),
          actions: <Widget>[
            RaisedButton(child: Icon(Icons.control_point),onPressed:(){
              Navigator.push(context, MaterialPageRoute(builder: (context){return new AddMenue(); }));
            } ,)
          ],
        ),
        body: ListView(
            // addAutomaticKeepAlives: false,

            children: <Widget>[
              // Container(
              //   child: Column(
              //     children: <Widget>[
              Container(
                  margin: const EdgeInsets.only(right: 0, top: 10),
                  // color: Colors.amber[600],
                  width: double.infinity,
                  height: 280,
                  decoration: rescardstyle, // for name of the restuarant

                  child: Container(
                    margin:
                        const EdgeInsets.only(bottom: 15, top: 10, left: 10),
                    // color: Colors.amber[600],
                    width: MediaQuery.of(context).size.width,
                    //  height: 100,
                    decoration: brescardstyle, // for name of the restuarant
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          // width: 300,
                          // width: 200,
                          margin: const EdgeInsets.only(top: 10),
                          height: 200,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadiusDirectional.only(
                                  bottomStart: Radius.circular(10),
                                  topStart: Radius.circular(10))
                              //   BorderRadiusDirectional.only(
                              //  bottomEnd: Radius.circular(20),topEnd:Radius.circular( 20)
                              ,
                              color: white),

                          child:
                              // Text("tset")
                              Container(
                                  width: MediaQuery.of(context).size.width * .5,
                                  child: Image.asset(widget.productData.image)),
                        ),
                        Container(
                            margin: const EdgeInsets.only(right: 5, top: 10),
                            padding: const EdgeInsets.only(top: 60),
                            height: 200,
                            // width: double.infinity,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadiusDirectional.only(
                                    bottomEnd: Radius.circular(10),
                                    topEnd: Radius.circular(10))
                                //   BorderRadiusDirectional.only(
                                //  bottomEnd: Radius.circular(20),topEnd:Radius.circular( 20)
                                ,
                                color: white),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  widget.productData.name,
                                  style: h3,
                                ),
                                Container(
                                  // width: double.infinity,
                                  margin: EdgeInsets.only(top: 5, bottom: 20),
                                  child: SmoothStarRating(
                                    allowHalfRating: false,
                                    onRatingChanged: (v) {
                                      setState(() {
                                        _rating = v;
                                      });
                                    },
                                    starCount: 5,
                                    rating: _rating,
                                    size: 27.0,
                                    color: Colors.orange,
                                    borderColor: Colors.orange,
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                  )),

          
                    Container(
                       margin: const EdgeInsets.only(right: 10, top: 10,left: 10),
                            padding: const EdgeInsets.only(top: 5),
                       decoration:BoxDecoration ( 
                            shape:BoxShape.rectangle ,
                            color: Colors.white,

                             borderRadius:BorderRadiusDirectional.only(bottomEnd:Radius.circular(10),topEnd:Radius.circular(10),bottomStart:Radius.circular(10),topStart:Radius.circular(10) )
                            //   BorderRadiusDirectional.only(
                            //  bottomEnd: Radius.circular(20),topEnd:Radius.circular( 20)
                            //   ,
                            // color: Colors.white),
                       ),
                        child:Center(child: Text(
                      "Menu",
                      style: TextStyle(
                        //  fontFamily: 'Pacifico',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ))),
                    
                                  foodItem(foods[0], onTapped: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return ;
                                        },
                                      ),
                                    );
                                  }, onLike: () {
                                    setState(() {
                                      (foods[0].userLiked)?foods[0].userLiked=false: foods[0].userLiked=true;
                                    });
                                  }),
                                  foodItem(foods[1], onTapped: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return ;
                                        },
                                      ),
                                    );
                                  }, onLike: () {
                                    setState(() {
                                      (foods[1].userLiked)?foods[1].userLiked=false: foods[1].userLiked=true;
                                    });
                                  }),
                                  foodItem(foods[2], onTapped: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return ;
                                        },
                                      ),
                                    );
                                  }, onLike: () {
                                     setState(() {
                                      (foods[2].userLiked)?foods[2].userLiked=false: foods[2].userLiked=true;
                                    });
                                  }),
                                foodItem(foods[3], onTapped: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return ;
                                        },
                                      ),
                                    );
                                  }, onLike: () {
                                    setState(() {
                                      (foods[3].userLiked)?foods[3].userLiked=false: foods[3].userLiked=true;
                                    });
                                  })


                          ],
                        
                 
            )
        // )])
        );
  }
}
