import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class FireStoreMethods {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String> signUpUser({
    required String name,
    required String email,
    required String phoneNo,
    required String password,
    required String cPassword,
  }) async {
    name.trim();
    email.trim();
    password.trim();
    phoneNo.trim();
    cPassword.trim();
    String output = "something went wrong";
    if (name != "" && email != "" && password != "" && cPassword == password) {
      try {
        await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        await FireStoreMethods()
            .uploadUserDetailsToDb(email: email, name: name, phone: phoneNo);
        output = "success";
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
    }
    return output;
  }

  Future uploadUserDetailsToDb({
    required String name,
    required String phone,
    required String email,
  }) async {
    await firebaseFirestore
        .collection("sellers")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      "sellerName": name,
      "isVerified": false,
      "phoneNo": phone,
      "email": email,
      "userType": "seller",
      "uid": FirebaseAuth.instance.currentUser?.uid,
      "shopId": FirebaseAuth.instance.currentUser?.uid,
    });
  }

  Future uploadGSTNo({
    required String gstNo,
  }) async {
    await firebaseFirestore
        .collection("sellers")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "gstNo": gstNo,
    });
  }

  Future uploadSellerAddress({
    required String pinCode,
    required String address,
    required String city,
    required String state,
  }) async {
    await firebaseFirestore
        .collection("sellers")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "pinCode": pinCode,
      "address": address,
      "city": city,
      "state": state,
    });
  }

  Future uploadShopName({
    required String shopName,
    required String shopAddress,
  }) async {
    await firebaseFirestore
        .collection("sellers")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "shopName": shopName,
      "shopAddress": shopAddress,
    });
  }

  Future uploadBankDetails({
    required String accountHolderName,
    required String accountNo,
  }) async {
    await firebaseFirestore
        .collection("sellers")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "accountHolderName": accountHolderName,
      "accountNo": accountNo,
    });
  }

  Future<String> uploadProductImage({required Uint8List image}) async {
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageRef =
        FirebaseStorage.instance.ref().child("productImages").child(timestamp);
    UploadTask uploadTask = storageRef.putData(image);
    TaskSnapshot task = await uploadTask;
    return task.ref.getDownloadURL();
  }

  Future<String> uploadProduct({
    required String productImage,
    required String category,
    required String productPrice,
    required String productCuttedPrice,
    required String stocks,
    required String deliveryFee,
    required String? shopId,
  }) async {
    String productId = DateTime.now().millisecondsSinceEpoch.toString();

    await firebaseFirestore.collection("products").doc(productId).set({
      "active": false,
      "isDetailsCompleted": false,
      "category": category,
      "productImage": productImage,
      "productPrice": productPrice,
      "productCuttedPrice": productCuttedPrice,
      "deliveryFee": deliveryFee,
      "noOfQuantity": stocks,
      "shopId": shopId,
      "trendingCount": "0",
      "productId": productId,
    });
    return productId;
  }

  Future<String> uploadDescription({
    required String productId,
    required String productTitle,
    required String productDescription,
    required String deliveryWithin,
    required bool isCod,
    required bool isTabSelected,
    required String allDetails,
  }) async {
    await firebaseFirestore.collection("products").doc(productId).update({
      "isCod": isCod,
      "isTabSelected": isTabSelected,
      "productTitle": productTitle,
      "productDescription": productDescription,
      "deliveryWithin": deliveryWithin,
      "allDetails": allDetails,
    });
    return productId;
  }

  Future<String> sendForQC({
    required String productId,
    required String banner1,
    required String banner2,
    required String banner3,
    required String banner4,
    required String banner5,
    required String banner6,
  }) async {
    DateTime time = DateTime.now();
    String timestamp = time.millisecondsSinceEpoch.toString();

    String date = DateFormat("MMM d, yyyy").format(DateTime.now());
    String tDate = DateFormat("hh:mm a").format(DateTime.now());

    await firebaseFirestore.collection("products").doc(productId).update({
      "banner1": banner1,
      "banner2": banner2,
      "banner3": banner3,
      "banner4": banner4,
      "banner5": banner5,
      "banner6": banner6,
      "isDetailsCompleted": true,
      "processedDate": date,
      "processedTime": tDate,
    });
    return productId;
  }

  Future markOrderStatusPacked({
    required String orderBy,
    required String orderId,
    required String orderFrom,
  }) async {
    String date = DateFormat("MMM d, yyyy").format(DateTime.now());
    String time = DateFormat("hh:mm a").format(DateTime.now());

    await firebaseFirestore
        .collection("users")
        .doc(orderBy)
        .collection("MyOrders")
        .doc(orderId)
        .update({
      "orderStatus": "packed",
      "orderPackedDate": date,
      "orderPackedTime": time,
    });
    await markOrderStatusPackedForSeller(
        orderFrom: orderFrom, orderId: orderId, date: date, time: time);
  }

  Future markOrderStatusPackedForSeller({
    required String orderId,
    required String orderFrom,
    required String date,
    required String time,
  }) async {
    await firebaseFirestore
        .collection("sellers")
        .doc(orderFrom)
        .collection("orders")
        .doc(orderId)
        .update({
      "orderStatus": "packed",
      "orderPackedDate": date,
      "orderPackedTime": time,
    });
  }

  Future markOrderStatusShipped({
    required String orderBy,
    required String orderId,
    required String orderFrom,
  }) async {
    String date = DateFormat("MMM d, yyyy").format(DateTime.now());
    String time = DateFormat("hh:mm a").format(DateTime.now());

    await firebaseFirestore
        .collection("users")
        .doc(orderBy)
        .collection("MyOrders")
        .doc(orderId)
        .update({
      "orderStatus": "shipped",
      "orderShippedDate": date,
      "orderShippedTime": time,
    });
    await markOrderStatusShippedForSeller(
        orderFrom: orderFrom, orderId: orderId, time: time, date: date);
  }

  Future markOrderStatusShippedForSeller({
    required String orderId,
    required String orderFrom,
    required String date,
    required String time,
  }) async {
    await firebaseFirestore
        .collection("sellers")
        .doc(orderFrom)
        .collection("orders")
        .doc(orderId)
        .update({
      "orderStatus": "shipped",
      "orderShippedDate": date,
      "orderShippedTime": time,
    });
  }

  Future markOrderStatusDelivered({
    required String orderBy,
    required String orderId,
    required String orderFrom,
  }) async {
    String date = DateFormat("MMM d, yyyy").format(DateTime.now());
    String time = DateFormat("hh:mm a").format(DateTime.now());

    await firebaseFirestore
        .collection("users")
        .doc(orderBy)
        .collection("MyOrders")
        .doc(orderId)
        .update({
      "orderStatus": "delivered",
      "orderDeliveredDate": date,
      "orderDeliveredTime": time,
    });
    await markOrderStatusDeliveredForSeller(
        orderFrom: orderFrom, orderId: orderId, time: time, date: date);
  }

  Future markOrderStatusDeliveredForSeller({
    required String orderId,
    required String orderFrom,
    required String date,
    required String time,
  }) async {
    await firebaseFirestore
        .collection("sellers")
        .doc(orderFrom)
        .collection("orders")
        .doc(orderId)
        .update({
      "orderStatus": "delivered",
      "orderDeliveredDate": date,
      "orderDeliveredTime": time,
    });
  }

  Future markOrderStatusRefunded({
    required String orderBy,
    required String orderId,
    required String orderFrom,
  }) async {
    String date = DateFormat("MMM d, yyyy").format(DateTime.now());
    String time = DateFormat("hh:mm a").format(DateTime.now());

    await firebaseFirestore
        .collection("users")
        .doc(orderBy)
        .collection("MyOrders")
        .doc(orderId)
        .update({
      "orderStatus": "refunded",
      "orderRefundedDate": date,
      "orderRefundedTime": time,
    });
    await markOrderStatusRefundedForSeller(
        orderFrom: orderFrom, orderId: orderId, time: time, date: date);
  }

  Future markOrderStatusRefundedForSeller({
    required String orderId,
    required String orderFrom,
    required String date,
    required String time,
  }) async {
    await firebaseFirestore
        .collection("sellers")
        .doc(orderFrom)
        .collection("orders")
        .doc(orderId)
        .update({
      "orderStatus": "refunded",
      "orderRefundedDate": date,
      "orderRefundedTime": time,
    });
  }

  Future updateStocks({
    required String productId,
    required String quantity,
  }) async {
    await firebaseFirestore
        .collection("products")
        .doc(productId)
        .update({
      "noOfQuantity": quantity,
    });
  }

  Future updateCategory({
    required String productId,
    required String category,
  }) async {
    await firebaseFirestore
        .collection("products")
        .doc(productId)
        .update({
      "category": category,
    });
  }

  Future<String> updateProduct({
    required String productImage,
    required String productPrice,
    required String productCuttedPrice,
    required String stocks,
    required String deliveryFee,
    required String productId,
  }) async {

    await firebaseFirestore.collection("products").doc(productId).update({
      "productImage": productImage,
      "productPrice": productPrice,
      "productCuttedPrice": productCuttedPrice,
      "deliveryFee": deliveryFee,
      "noOfQuantity": stocks,
    });
    return productId;
  }

  Future updateDescription({
    required String productId,
    required String productTitle,
    required String productDescription,
    required String deliveryWithin,
    required bool isCod,
    required String allDetails,
  }) async {
    await firebaseFirestore.collection("products").doc(productId).update({
      "isCod": isCod,
      "productTitle": productTitle,
      "productDescription": productDescription,
      "deliveryWithin": deliveryWithin,
      "allDetails": allDetails,
    });
  }

  Future updateForQC({
    required String productId,
    required String banner1,
    required String banner2,
    required String banner3,
    required String banner4,
    required String banner5,
    required String banner6,
  }) async {
    await firebaseFirestore.collection("products").doc(productId).update({
      "banner1": banner1,
      "banner2": banner2,
      "banner3": banner3,
      "banner4": banner4,
      "banner5": banner5,
      "banner6": banner6,
    });
  }

}
