import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drive_thru/root.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

// passed value between pages specially for wallet page
double valuepaseed = 0.0;

// create new class
class WalletMangement {
// new variables to reseive the data form the database online
  double userWalletValue = 0.0;
  double newwallet = 0.0;

// this function is responsible to get the wallet amount of the current user
  currentuserwallet() async {
    await Firestore.instance
        .collection("users")
        .document(uID) // uID is global variabe passed by root page
        .get()
        .then((DocumentSnapshot userWallet) {
      userWalletValue = userWallet.data["wallet"];
    });
  }

// walletdecrease function is set to get the data from the online data and update the date + setting the passed value
  walletdecrease(context, totalprice) async {
    await Firestore.instance
        .collection("users")
        .document(uID) // uID is global variabe passed by root page
        .get()
        .then((DocumentSnapshot userWallet) {
      userWalletValue = userWallet.data["wallet"];
    });
    newwallet = userWalletValue - totalprice;

    // check if it's possible to buy or the charge isn't enough
    if (newwallet > 0) {
      // calculate new value to update user wallet

      valuepaseed =
          newwallet; // this to pass value of the walelt in the wallt page
      // update data in the firestore field  of the current user
      await Firestore.instance
          .collection("users")
          .document(uID)
          .updateData({"wallet": newwallet});

      AlertDialog alert = AlertDialog(
        title: Text("Done"),
        content: Text("Your order has been confirmed "),
        actions: [
          FlatButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    } // updating data
    else {
      AlertDialog alert = AlertDialog(
        title: Text("Sorry 🙂"),
        content: Text("please check your wallet "),
        actions: [
          FlatButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  updatewalletbymail(context, {useremail, value}) async {
    /// context for widget
    /// user email to update it's wallet
    /// value the will be add to the wallet
    //  assert (useremail !=null);
// query snapshopt to get data of the email // user id and walllet amount
    QuerySnapshot querySnapshot;
    querySnapshot = await Firestore.instance
        .collection("users")
        .where("Email", isEqualTo: useremail)
        .getDocuments(); // get the document of the given email

    AlertDialog donealert = AlertDialog(
      title: Text("Done 🙂"),
      content: Text("Charged Successfuly "),
      actions: [
        FlatButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    AlertDialog emptyalert = AlertDialog(
      title: Text("Sorry "),
      content: Text("invalid email or value "),
      actions: [
        FlatButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    if (isNumeric(value)) {
      value = double.parse(value);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return emptyalert;
        },
      );
    }
    if (querySnapshot.documents.length > 0 && value > 0) {
      double currentWalletValue = querySnapshot
          .documents[0].data["wallet"]; // wallet value of the email
      String userid =
          querySnapshot.documents[0].data["uid"]; // it's user generated id

      double newValue = value +
          currentWalletValue; // update value of the wallet in the account

// function that is responsble for updating  data
      await Firestore.instance
          .collection("users")
          .document(userid)
          .updateData({"wallet": newValue});

      valuepaseed = newValue;

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return donealert;
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return emptyalert;
        },
      );
    }
  }

// charge the wallet by adding the give value in the txt field
  addTowallet(value, context, account) async {
    double addvalue = 0;
    await Firestore.instance
        .collection("users")
        .document(uID)
        .get()
        .then((DocumentSnapshot userWallet) {
      userWalletValue = userWallet.data["wallet"];
    });
    addvalue = userWalletValue + value;
    // calculate new value to update user wallet
    await Firestore.instance
        .collection("users")
        .document(uID)
        .updateData({"wallet": addvalue});
    valuepaseed = addvalue;
    AlertDialog alert = AlertDialog(
      title: Text("Done 🙂"),
      content: Text("Charged Successfuly "),
      actions: [
        FlatButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
