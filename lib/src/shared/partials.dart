import 'package:flutter/material.dart';
import '../shared/Product.dart';
import '../shared/colors.dart';
import '../shared/styles.dart';

/*Widget resitem(Product food,
    {double imgWidth, onLike, onTapped, bool isProductPage = false}){
 
  return 
  Container(
    // width: MediaQuery.of().size.width * 0.65,

    // height: 180,
    // color: Colors.red,
    margin: EdgeInsets.all(3),
    child: 
  
    Stack(
      children: <Widget>[
        Container(
          //  width: double.infinity,
          height: 190,
          width:500,
          padding: EdgeInsets.all(9),
          
            child:
             RaisedButton(
            
            color: white,
            elevation: (isProductPage) ? 20 : 12,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            onPressed: onTapped,
            child: Hero(
              transitionOnUserGestures: true,
              tag: food.name,
             
              child: Image.asset(food.image,
                  width: (imgWidth != null) ? imgWidth : 100),
                  
            ),
          ),
        ),
        
        Positioned( // for like button 
          
          bottom: (isProductPage) ? 10 : 70,
          right: 0,
          child: FlatButton(
            padding: EdgeInsets.all(20),
            shape: CircleBorder(),
            onPressed: onLike,
            child: Icon(
              (food.userLiked) ? Icons.favorite : Icons.favorite_border,
              color: (food.userLiked) ? primaryColor : darkText,
              size: 30,
            ),
          ),
        ),
        Positioned( // for text in the menu card 
          bottom: 10,
          left:10,
          child: (!isProductPage)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(food.name, style: foodNameText),
                  ],
                )
              : Text(' '),
        ),
      
      ],
    ),
  );
}*/

Widget resitem2(String food, {onTapped, imgURL, context}
    //{, onLike, bool isProductPage = false}){
    ) {
  return Container(
    margin: EdgeInsets.all(3),
    child: Stack(
      children: <Widget>[
        Container(
          //width: double.infinity,
          height: MediaQuery.of(context).size.height*0.37,
          width: MediaQuery.of(context).size.width*0.99,
          padding: EdgeInsets.all(9),

          child: RaisedButton(
            color: white,
            elevation: (false) ? 20 : 12,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            onPressed: onTapped,
            child: Hero(
                transitionOnUserGestures: false,
                tag: food,
                child: CircleAvatar(
                  radius: 75.0,
                  backgroundImage: NetworkImage(imgURL),
                  backgroundColor: Colors.transparent,
                )),
          ),
        ),
        // Positioned(
        //   // for like button
        //   bottom: (false) ? 10 : 70,
        //   right: 0,
        //   child: FlatButton(
        //     padding: EdgeInsets.all(20),
        //     shape: CircleBorder(),
        //     onPressed: () {},
        //     child: Icon(
        //       (true) ? Icons.favorite : Icons.favorite_border,
        //       color: (true) ? primaryColor : darkText,
        //       size: 22,
        //     ),
        //   ),
        // ),
        Positioned(
          // for text in the menu card
          top: 178,
          left: 20,
          child: (!false)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(food, style: foodNameText),
                  ],
                )
              : Text(' '),
        ),
      ],
    ),
  );
}

Widget foodItem(String food,
    {bool isProductPage = false, String imageURL, double price}) {
  return Container(
    width: 180,
    height: 150,
    padding: EdgeInsets.all(6),
    // color: Colors.red,
    margin: EdgeInsets.only(left: 20),
    child: Stack(
      children: <Widget>[
        Container(
            width: 400,
            height: 150,
            child: RaisedButton(
                color: white,
                elevation: (true) ? 20 : 12,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                onPressed: (){},
                child: Hero(
                    transitionOnUserGestures: true,
                    tag: food,
                    child: CircleAvatar(
                  radius: 60.0,
                  backgroundImage: NetworkImage(imageURL),
                  backgroundColor: Colors.transparent,
                ),
        // Positioned(
        //   bottom: (isProductPage) ? 10 : 70,
        //   right: 0,
        //   child: FlatButton(
        //     padding: EdgeInsets.all(20),
        //     shape: CircleBorder(),
        //     onPressed: onLike,
        //     child: Icon(
        //       (food.userLiked) ? Icons.favorite : Icons.favorite_border,
        //       color: (food.userLiked) ? primaryColor : darkText,
        //       size: 30,
        //     ),
        //   ),
        // ),
        // Positioned(
        //   bottom: 0,
        //   left: 0,
        //   child: (!true)
        //       ? Column(
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: <Widget>[
        //             Text(food, style: foodNameText),
        //             Text(price, style: priceText),
        //           ],
        //         )
        //       : Text(' '),
        // ),
        // Positioned(
        //     top: 10,
        //     left: 10,
        //     child: (food.discount != null)
        //         ? Container(
        //             padding:
        //                 EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
        //             decoration: BoxDecoration(
        //                 color: Colors.grey[600],
        //                 borderRadius: BorderRadius.circular(50)),
                    // child: Text('-' + food.discount.toString() + '%',
                    //     style: TextStyle(
                    //         color: Colors.white, fontWeight: FontWeight.w700)),
                 // )
                //: SizedBox(width: 0))
                ),
    ),
      )]));
}

/*Widget rest(Product food,
    {double imgWidth, onLike, onTapped, bool isProductPage = false}) {
  return Container(
    width: 180,
    height: 150,
    padding: EdgeInsets.all(6),
    // color: Colors.red,
    margin: EdgeInsets.only(left: 2),
    child: Stack(
      children: <Widget>[
        Container(
            width: 400,
            height: 150,
            child: RaisedButton(
                color: white,
                elevation: (isProductPage) ? 20 : 12,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                onPressed: onTapped,
                child: Hero(
                    transitionOnUserGestures: true,
                    tag: food.name,
                    child: Image.asset(food.image,
                        width: (imgWidth != null) ? imgWidth : 100)))),
        Positioned(
          bottom: (isProductPage) ? 10 : 70,
          right: 0,
          child: FlatButton(
            padding: EdgeInsets.all(20),
            shape: CircleBorder(),
            onPressed: onLike,
            child: Icon(
              (food.userLiked) ? Icons.favorite : Icons.favorite_border,
              color: (food.userLiked) ? primaryColor : darkText,
              size: 30,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: (!isProductPage)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(food.name, style: foodNameText),
                    Text(food.price, style: priceText),
                  ],
                )
              : Text(' '),
        ),
        Positioned(
            top: 10,
            left: 10,
            child: (food.discount != null)
                ? Container(
                    padding:
                        EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
                    decoration: BoxDecoration(
                        color: Colors.grey[600],
                        borderRadius: BorderRadius.circular(50)),
                    child: Text('-' + food.discount.toString() + '%',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700)),
                  )
                : SizedBox(width: 0))
      ],
    ),
  );
}*/
