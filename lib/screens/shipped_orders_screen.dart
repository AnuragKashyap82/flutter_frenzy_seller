import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../animations/fade_animation.dart';
import '../widgets/order_widget.dart';

class ShippedOrdersScreen extends StatefulWidget {
  const ShippedOrdersScreen({Key? key}) : super(key: key);

  @override
  State<ShippedOrdersScreen> createState() => _ShippedOrdersScreenState();
}

class _ShippedOrdersScreenState extends State<ShippedOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shipped orders",
          style: TextStyle(fontSize: 16, color: Colors.white),
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
                        .collection("sellers")
                        .doc(FirebaseAuth.instance.currentUser?.uid)
                        .collection("orders")
                        .where("orderStatus", isEqualTo: "shipped")
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

                            child: Container(
                              child: FadeAnimation(
                                1.1,
                                OrdersWidget(
                                  snap:
                                  snapshot.data!.docs[index].data(),
                                  code: "5",
                                ),
                              ),
                            ),
                          ));
                    }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
