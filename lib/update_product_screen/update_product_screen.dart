import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frenzy_seller/resources/firestore_methods.dart';
import 'package:frenzy_seller/update_product_screen/update_product_details_screen.dart';

import '../../animations/fade_animation.dart';
import '../../widgets/choose_category_widgets.dart';
import '../utils/utils.dart';

class UpdateProductScreen extends StatefulWidget {
  final snap;
  const UpdateProductScreen({Key? key, required this.snap}) : super(key: key);

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  String selectedCategory = "";
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedCategory = widget.snap['category'];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Update Product",
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CupertinoSearchTextField(
                      padding: EdgeInsets.all(14),
                      style: TextStyle(fontSize: 14, letterSpacing: 0.5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.blue)),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Your Category",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 26),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade600)),
                      child:  Text(selectedCategory),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Alternatively choose your category from below options",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    const Text(
                      "All Categories",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Container(
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("category")
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<
                                        QuerySnapshot<Map<String, dynamic>>>
                                    snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: snapshot.data!.docs.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedCategory = snapshot.data!.docs[index]['categoryName'];
                                          });
                                        },
                                        child: Container(
                                          child: FadeAnimation(
                                            1.1,
                                            ChooseCategoryWidget(
                                              snap: snapshot.data!.docs[index]
                                                  .data(),
                                            ),
                                          ),
                                        ),
                                      ));
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: SizedBox(
              width: double.infinity,
              height: 46,
              child: FadeAnimation(
                1.7,
                ElevatedButton(
                  onPressed: () async {
                    if(selectedCategory != "Not Yet Selected"){
                      setState(() {
                        _isLoading = true;
                      });
                      FireStoreMethods().updateCategory(productId: widget.snap['productId'], category: selectedCategory).then((value) {
                        setState(() {
                          _isLoading = false;
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => UpdateProductDetailsScreen(
                                snap: widget.snap,
                              )));
                        });
                      });

                    }else{
                      Utils().showSnackBar(context, "Select Your category!!!");
                    }
                  },
                  style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                  child: _isLoading ? CircularProgressIndicator(strokeWidth: 1, color: Colors.white,):
                  Text("Update".toLowerCase()),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
