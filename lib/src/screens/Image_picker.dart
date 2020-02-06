// import 'package:drive_thru/src/screens/ResturantList.dart';
// import 'package:drive_thru/src/screens/Dashboard.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:drive_thru/src/services/resturantManagement.dart';
// import '../shared/styles.dart';
// import '../shared/colors.dart';
// import 'dart:core';
// import 'dart:io';
// import 'dart:async';
// import 'package:image_picker/image_picker.dart';
// import '../shared/buttons.dart';

// import 'Dashboard.dart';

// class Image_picker extends StatefulWidget {
//   @override
//   _Image_pickerState createState() => new _Image_pickerState();
// }

// class _Image_pickerState extends State<Image_picker> {
//   File _image;

//   Future getImage() async {
//     var image = await ImagePicker.pickImage(source: ImageSource.camera);

//     setState(() {
//       _image = image;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text('Image Picker Example'),
//       ),
//       body: new Center(
//         child: _image == null
//             ? new Text('No image selected.')
//             : new Image.file(_image),
//       ),
//       floatingActionButton: new FloatingActionButton(
//         onPressed: getImage,
//         tooltip: 'Pick Image',
//         child: new Icon(Icons.add_a_photo),
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drive_thru/src/screens/AddResturant.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path; 


class Image_picker extends StatefulWidget{
  
  Image_picker(this.docid);
  final String docid;
  @override
  _Image_pickerState createState() => _Image_pickerState();

}
class _Image_pickerState extends State<Image_picker>{

  File _image;
  String _uploadedFileURL; 

    _openGallery(BuildContext context) async{
      var picture= await ImagePicker.pickImage(source: ImageSource.gallery);
      this.setState((){
        _image= picture;
      }

      );
      Navigator.of(context).pop();
    }

    _openCamera(BuildContext context) async{
            var picture= await ImagePicker.pickImage(source: ImageSource.camera);
      this.setState((){
        _image= picture;
      }

      );
      Navigator.of(context).pop();
    }

  Future<void> _showChoiceDialog(BuildContext context){
    return showDialog(context:context,builder: (BuildContext context){
      return AlertDialog(
        title: Text("Make a choice!"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text("Gallery"),
                onTap: (){
                  _openGallery(context);
                },
              ),
              Padding(padding: EdgeInsets.all(8)),

              GestureDetector(
                child: Text("Camera"),
                onTap: (){
                  _openCamera(context);
                },
              )
            ],
          ),
        ),
      );
    });
  } 

  Future uploadFile() async {    
   StorageReference storageReference = FirebaseStorage.instance    
       .ref()    
       .child('restlogos/${Path.basename(_image.path)}}');    
   StorageUploadTask uploadTask = storageReference.putFile(_image);    
   await uploadTask.onComplete;
   //String v = await storageReference.getDownloadURL().toString();
   print('File Uploaded');    
  //  storageReference.getDownloadURL().then((fileURL) {    
  //    setState(() {    
  //      _uploadedFileURL = fileURL.toString();
  //    });    
  //  });
  var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
  var url = downUrl.toString();
  _uploadedFileURL = url;
   return  url;   
 } 

 _updateData(var imageURL) async {
    await Firestore.instance
        .collection('/Restaurants')
        .document(widget.docid)
        .updateData({'imageURL': imageURL});
    print('image URL updated');
} 

  Widget _decideImageView(){
    if(_image==null){
      return Text("No image Selected");
    }
    else{
      return Image.file(_image, width:400, height:400);
    }
  }

  @override



  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Image"),
      ),
        body:Container(
          child:Center(
            child: Column(
            mainAxisAlignment:MainAxisAlignment.spaceAround,
            children:<Widget>[
              _decideImageView(),
              RaisedButton(onPressed: (){
                _showChoiceDialog(context);

              }, child: Text("Select Image!"),
              )
              ,
              RaisedButton(onPressed: (){
                uploadFile()
                  .then((url){
                    _updateData(url);
                    print(url);
                });
                //print(_uploadedFileURL);
                
                


              }, child: Text("Upload"),
              ),
            ]
          )
          )
          
        ),
    );
  }
}