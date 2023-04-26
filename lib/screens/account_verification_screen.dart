import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frenzy_seller/screens/home.dart';

import '../utils/utils.dart';

class AccountVerificationScreen extends StatefulWidget {
  const AccountVerificationScreen({Key? key}) : super(key: key);

  @override
  State<AccountVerificationScreen> createState() =>
      _AccountVerificationScreenState();
}

class _AccountVerificationScreenState extends State<AccountVerificationScreen> {
  bool _isLoadingDetails = false;
  var _sellerData = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadSellerDetails();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void loadSellerDetails() async {
    setState(() {
      _isLoadingDetails = true;
    });
    try {
      var sellerSnap = await FirebaseFirestore.instance
          .collection("sellers")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
      if (sellerSnap.exists) {
        setState(() {
          _sellerData = sellerSnap.data()!;
        });
        if (_sellerData['isVerified']) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        } else {
          setState(() {
            _isLoadingDetails = false;
          });
        }
      } else {}
    } catch (e) {
      Utils().showSnackBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoadingDetails
            ? Center(
                child: CircularProgressIndicator(
                color: Colors.blue,
                strokeWidth: 1,
              ))
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:  [
                    const  Text(
                        "Account Verification in Progress!!",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const  Text(
                        "Account Verification may take 8 to 12 hours approx to verify your details provided!!!",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w100,
                          color: Colors.black54,
                        ),
                      ),
                      const   SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Shop Name: ${_sellerData['shopName']}",
                        style:const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w100,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
