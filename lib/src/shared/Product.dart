class Order
{
  String date;
  double price;
  String time;
  bool userLiked;
  double discount;
  String mealname;
  String resturantid;
  String deliveryDetails; 
  String imageurl;
  int itemQuantity;
  int timeToDone;
  double ordertotal;
  bool getProduct;

  Order({
    this.date,
    this.price,
    this.time,
    this.discount,
    this.mealname,
    this.userLiked,
    this.deliveryDetails,
    this.resturantid,
    this.imageurl,
    this.itemQuantity,
    this.timeToDone,
    this.getProduct
  });

}