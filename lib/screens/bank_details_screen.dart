import 'package:flutter/material.dart';
import 'package:frenzy_seller/resources/firestore_methods.dart';
import 'package:frenzy_seller/screens/account_verification_screen.dart';
import 'package:frenzy_seller/utils/utils.dart';

import '../animations/fade_animation.dart';

class BankDetailsScreen extends StatefulWidget {
  const BankDetailsScreen({Key? key}) : super(key: key);

  @override
  State<BankDetailsScreen> createState() => _BankDetailsScreenState();
}

class _BankDetailsScreenState extends State<BankDetailsScreen> {
  bool _isLoading = false;
  TextEditingController _accountHolderNameController = TextEditingController();
  TextEditingController _bankAccountNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = 400;
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
                                  "Give Your Bank Details",
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
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: const Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting "
                              "industry. Lorem Ipsum has been the industry's standard dummy text "
                              "ever since the 1500s, when an unknown printer took a galley of type "
                              "and scrambled it to make a type specimen book. It has survived not ",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w100,
                                  color: Colors.black87),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          FadeAnimation(
                              1.3,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 32),
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  controller: _accountHolderNameController,
                                  style: TextStyle(fontSize: 12),
                                  decoration: InputDecoration(
                                    label: Text("Account Holder Name"),
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
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  controller: _bankAccountNoController,
                                  style: TextStyle(fontSize: 12),
                                  decoration: InputDecoration(
                                    label: Text("Enter Bank Account No"),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5),
                                        borderSide:
                                            BorderSide(color: Colors.blue)),
                                  ),
                                ),
                              )),
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
                                        if (_accountHolderNameController
                                            .text.isEmpty) {
                                          Utils().showSnackBar(context,
                                              "Enter Account Holder Name!!!");
                                        } else if (_bankAccountNoController
                                            .text.isEmpty) {
                                          Utils().showSnackBar(
                                              context, "Enter Account No!!!");
                                        } else {
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          FireStoreMethods()
                                              .uploadBankDetails(
                                                  accountHolderName:
                                                      _bankAccountNoController
                                                          .text,
                                                  accountNo:
                                                      _bankAccountNoController
                                                          .text)
                                              .then((value) {
                                            setState(() {
                                              _isLoading = false;
                                            });
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        AccountVerificationScreen()));
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
