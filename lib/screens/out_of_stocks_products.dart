import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frenzy_seller/screens/product_details_screen.dart';
import 'package:frenzy_seller/screens/update_stock_screen.dart';
import 'package:frenzy_seller/widgets/out_of_stocks_widget.dart';

import '../animations/fade_animation.dart';

class OutOfStocksProducts extends StatefulWidget {
  const OutOfStocksProducts({Key? key}) : super(key: key);

  @override
  State<OutOfStocksProducts> createState() => _OutOfStocksProductsState();
}

class _OutOfStocksProductsState extends State<OutOfStocksProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Out Of Stock Products",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 60),
          child: PhysicalModel(
            color: Colors.white,
            shadowColor: Colors.blue,
            elevation: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("products")
                        .where("shopId",
                            isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                        .where("noOfQuantity", isEqualTo: "0")
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        );
                      }
                      return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => UpdateStockScreen(snap: snapshot.data!.docs[index].data(),)));
                                },
                                child: Container(
                                  child: FadeAnimation(
                                    1.1,
                                    OutOfStockWidget(
                                      snap: snapshot.data!.docs[index].data(),
                                    ),
                                  ),
                                ),
                              ));
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
