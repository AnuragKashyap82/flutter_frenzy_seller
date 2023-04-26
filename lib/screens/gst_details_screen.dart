import 'package:flutter/material.dart';
import 'package:frenzy_seller/resources/firestore_methods.dart';
import 'package:frenzy_seller/screens/pick_up_address_screen.dart';
import 'package:frenzy_seller/utils/utils.dart';

import '../animations/fade_animation.dart';

class GSTDetailsScreen extends StatefulWidget {
  const GSTDetailsScreen({Key? key}) : super(key: key);

  @override
  State<GSTDetailsScreen> createState() => _GSTDetailsScreenState();
}

class _GSTDetailsScreenState extends State<GSTDetailsScreen> {
  bool _isLoading = false;
  TextEditingController _gstNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.blue.shade100,
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  width: 300,
                  height: 380,
                  child: Center(
                    child: PhysicalModel(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(26),
                      shadowColor: Colors.blue,
                      elevation: 7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 16,
                          ),
                          FadeAnimation(
                            1.3,
                            Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 32),
                                child: Text(
                                  "Provide Your Bussiness Details",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 26,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Row(
                              children: [
                                Container(
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(26)),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  "To be integrated!!!",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Row(
                              children: [
                                Container(
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(26)),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  "To be integrated!!!",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Row(
                              children: [
                                Container(
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(26)),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  "To be integrated!!!",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 26,
                          ),
                          FadeAnimation(
                              1.3,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 32),
                                child: Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    maxLength: 15,
                                    controller: _gstNoController,
                                    style: TextStyle(fontSize: 12),
                                    decoration: InputDecoration(
                                      label: Text("Enter Your GSTIN Number"),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide:
                                              BorderSide(color: Colors.blue)),
                                    ),
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 80,
                          ),
                          SizedBox(
                              width: double.infinity,
                              height: 46,
                              child: FadeAnimation(
                                  1.7,
                                  FadeAnimation(
                                    1.9,
                                    ElevatedButton(
                                        onPressed: () async {
                                          if (_gstNoController.text.length <
                                              15) {
                                            Utils().showSnackBar(context,
                                                "GST no should contains 15 characters!!!");
                                          } else {
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            FireStoreMethods()
                                                .uploadGSTNo(
                                                    gstNo:
                                                        _gstNoController.text)
                                                .then((value) {
                                              setState(() {
                                                _isLoading = false;
                                              });
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          PickUpAddressScreen()));
                                            });
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                            shape: StadiumBorder()),
                                        child: _isLoading
                                            ? CircularProgressIndicator(
                                                color: Colors.white,
                                              )
                                            : Text("Sign In".toLowerCase())),
                                  ))),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
