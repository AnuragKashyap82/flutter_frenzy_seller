import 'package:flutter/material.dart';
import 'package:frenzy_seller/resources/firestore_methods.dart';
import 'package:frenzy_seller/screens/shop_details_screen.dart';
import 'package:frenzy_seller/utils/utils.dart';

import '../animations/fade_animation.dart';

class PickUpAddressScreen extends StatefulWidget {
  const PickUpAddressScreen({Key? key}) : super(key: key);

  @override
  State<PickUpAddressScreen> createState() => _PickUpAddressScreenState();
}

class _PickUpAddressScreenState extends State<PickUpAddressScreen> {
  bool _isLoading = false;
  TextEditingController _pinCodeController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();

  @override
  Widget build(BuildContext context) {


    double height = 500;
    double width = 350;

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.blue.shade100,
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  width: width,
                  height: height,
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
                                  "Give Your Pick Up address",
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
                            height: 30,
                          ),
                          FadeAnimation(
                              1.3,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 32),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: _pinCodeController,
                                  textInputAction: TextInputAction.next,
                                  style: TextStyle(fontSize: 12),
                                  decoration: InputDecoration(
                                    label: Text("Pin Code"),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5),
                                        borderSide:
                                            BorderSide(color: Colors.blue)),
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 12,
                          ),
                          FadeAnimation(
                              1.3,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 32),
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  controller: _addressController,
                                  style: TextStyle(fontSize: 12),
                                  decoration: InputDecoration(
                                    label: Text("Address"),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5),
                                        borderSide:
                                            BorderSide(color: Colors.blue)),
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 12,
                          ),
                          FadeAnimation(
                              1.3,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 32),
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  controller: _cityController,
                                  style: TextStyle(fontSize: 12),
                                  decoration: InputDecoration(
                                    label: Text("City"),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5),
                                        borderSide:
                                            BorderSide(color: Colors.blue)),
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 12,
                          ),
                          FadeAnimation(
                              1.3,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 32),
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  controller: _stateController,
                                  style: TextStyle(fontSize: 12),
                                  decoration: InputDecoration(
                                    label: Text("State"),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5),
                                        borderSide:
                                            BorderSide(color: Colors.blue)),
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 12,
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          FadeAnimation(
                            1.3,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 32),
                              child: Text(
                                "This will be your pickUp Address",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black87),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          SizedBox(
                              width: double.infinity,
                              height: 46,
                              child: FadeAnimation(
                                1.5,
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32),
                                  child: ElevatedButton(
                                      onPressed: () async {

                                        if (_pinCodeController.text.isEmpty) {
                                          Utils().showSnackBar(
                                              context, "Enter Pin Code!!!");
                                        } else if (_addressController
                                            .text.isEmpty) {
                                          Utils().showSnackBar(context,
                                              "Enter Complete Address!!!");
                                        } else if (_cityController
                                            .text.isEmpty) {
                                          Utils().showSnackBar(
                                              context, "EnterCity!!!");
                                        } else if (_stateController
                                            .text.isEmpty) {
                                          Utils().showSnackBar(
                                              context, "Enter State!!!");
                                        } else {
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          FireStoreMethods()
                                              .uploadSellerAddress(
                                            pinCode: _pinCodeController.text,
                                            address: _addressController.text,
                                            city: _cityController.text,
                                            state: _stateController.text,
                                          )
                                              .then((value) {
                                            setState(() {
                                              _isLoading = false;
                                            });
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        ShopDetailsScreen()));
                                          });
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          shape: StadiumBorder()),
                                      child: _isLoading
                                          ? CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2,
                                            )
                                          : Text("Continue")),
                                ),
                              )),
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
