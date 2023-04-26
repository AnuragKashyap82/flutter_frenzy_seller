import 'package:flutter/material.dart';
import 'package:frenzy_seller/resources/firestore_methods.dart';
import 'package:frenzy_seller/utils/utils.dart';

import '../animations/fade_animation.dart';

class UpdateStockScreen extends StatefulWidget {
  final snap;
  const UpdateStockScreen({Key? key,required this.snap}) : super(key: key);

  @override
  State<UpdateStockScreen> createState() => _UpdateStockScreenState();
}

class _UpdateStockScreenState extends State<UpdateStockScreen> {
  TextEditingController _quantityController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Update Stock",
          style: TextStyle(fontSize: 14),
        ),
      ),
      body:
      Center(
        child: Container(
          width: 350,
          height: 350,
          child: Center(
            child: PhysicalModel(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(26),
              shadowColor: Colors.blue,
              elevation: 7,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    FadeAnimation(
                        1.3,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              controller: _quantityController,
                              style: TextStyle(fontSize: 12),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                hintText: "Enter Quantity No.",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(26),
                                    borderSide: BorderSide(color: Colors.blue)),
                              ),
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
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (_quantityController.text.isEmpty) {
                                    Utils().showSnackBar(
                                        context, "Enter quantity");
                                  } else {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    FireStoreMethods()
                                        .updateStocks(
                                      productId: widget.snap['productId'], quantity: _quantityController.text,)
                                        .then((value) {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      Navigator.pop(context);
                                    });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: StadiumBorder()),
                                child: _isLoading ? CircularProgressIndicator(
                                  strokeWidth: 1, color: Colors.white,):
                                Text("Update Stocks".toLowerCase())),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
