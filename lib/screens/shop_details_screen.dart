import 'package:flutter/material.dart';
import 'package:frenzy_seller/resources/firestore_methods.dart';
import 'package:frenzy_seller/screens/bank_details_screen.dart';
import 'package:frenzy_seller/utils/utils.dart';

import '../animations/fade_animation.dart';

class ShopDetailsScreen extends StatefulWidget {
  const ShopDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ShopDetailsScreen> createState() => _ShopDetailsScreenState();
}

class _ShopDetailsScreenState extends State<ShopDetailsScreen> {
  bool _isLoading = false;
  bool _throwShotAway = false;

  TextEditingController _shopNameController = TextEditingController();
  TextEditingController _shopAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeAnimation(
                    1.3,
                    const Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          "Give Your Shop Details",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  FadeAnimation(
                      1.3,
                      Padding(
                        padding: const EdgeInsets.only(right: 64),
                        child: TextField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          controller: _shopNameController,
                          style: TextStyle(fontSize: 12),
                          decoration: InputDecoration(
                            label: Text("Shop Name"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Colors.blue)),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 12,
                  ),
                  FadeAnimation(
                      1.3,
                      Padding(
                        padding: const EdgeInsets.only(right: 64),
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.next,
                          controller: _shopAddressController,
                          maxLines: 4,
                          style: TextStyle(fontSize: 12),
                          decoration: InputDecoration(
                            label: Text("Shop Address"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Colors.blue)),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "Address Proof",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting "
                    "industry. Lorem Ipsum has been the industry's standard dummy text "
                    "ever since the 1500s, when an unknown printer took a galley of type "
                    "and scrambled it to make a type specimen book. It has survived not "
                    "only five centuries, but also the leap into electronic typesetting,"
                    " remaining essentially unchanged. It was popularised in the 1960s with"
                    " the release of Letraset sheets containing Lorem Ipsum passages, and more"
                    " recently with desktop publishing software like Aldus PageMaker including "
                    "versions of Lorem Ipsum.",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w100,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_a_photo_rounded,
                        size: 42,
                        color: Colors.grey.shade300,
                      ),
                      SizedBox(
                        width: 26,
                      ),
                      Container(
                        width: 180,
                        padding:
                            EdgeInsets.symmetric(horizontal: 26, vertical: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.blue)),
                        child: Center(
                            child: Text(
                          "Upload",
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        )),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "Signature",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting "
                    "industry. Lorem Ipsum has been the industry's standard dummy text "
                    "ever since the 1500s, when an unknown printer took a galley of type "
                    "and scrambled it to make a type specimen book. It has survived not "
                    "only five centuries, but also the leap into electronic typesetting,"
                    " remaining essentially unchanged. It was popularised in the 1960s with"
                    " the release of Letraset sheets containing Lorem Ipsum passages, and more"
                    " recently with desktop publishing software like Aldus PageMaker including "
                    "versions of Lorem Ipsum.",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w100,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_a_photo_rounded,
                        size: 42,
                        color: Colors.grey.shade300,
                      ),
                      SizedBox(
                        width: 26,
                      ),
                      Container(
                        width: 180,
                        padding:
                            EdgeInsets.symmetric(horizontal: 26, vertical: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.blue)),
                        child: Center(
                            child: Text(
                          "Upload",
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        )),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 46,
                      child: FadeAnimation(
                        1.5,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: ElevatedButton(
                              onPressed: () async {
                                if (_shopNameController.text.isEmpty) {
                                  Utils().showSnackBar(
                                      context, "Enter Shop Name!!!");
                                } else if (_shopAddressController
                                    .text.isEmpty) {
                                  Utils().showSnackBar(
                                      context, "Enter Shop Address!!!");
                                } else {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  FireStoreMethods()
                                      .uploadShopName(
                                          shopName: _shopNameController.text,
                                          shopAddress:
                                              _shopAddressController.text)
                                      .then((value) {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                BankDetailsScreen()));
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
          )),
    );
  }
}
