import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frenzy_seller/screens/product_details_screen.dart';
import 'package:frenzy_seller/widgets/active_products_widget.dart';

import '../animations/fade_animation.dart';

class ActiveProductsScreen extends StatefulWidget {
  const ActiveProductsScreen({Key? key}) : super(key: key);

  @override
  State<ActiveProductsScreen> createState() => _ActiveProductsScreenState();
}

class _ActiveProductsScreenState extends State<ActiveProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Active Products",
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
                    .where("active", isEqualTo: true)
                        .where("shopId",
                        isEqualTo: FirebaseAuth.instance.currentUser?.uid)
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
                                      builder: (_) => ProductDetailsScreen(snap: snapshot.data!.docs[index].data())));
                            },
                            child: Container(
                              child: FadeAnimation(
                                1.1,
                                ActiveProductWidget(
                                  snap:
                                  snapshot.data!.docs[index].data(),
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
