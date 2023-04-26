import 'package:flutter/material.dart';
import 'package:frenzy_seller/update_product_screen/update_product_all_images.dart';

import '../animations/fade_animation.dart';
import '../resources/firestore_methods.dart';
import '../utils/utils.dart';

class UpdateProductDescriptionScreen extends StatefulWidget {
  final snap;
  const UpdateProductDescriptionScreen({Key? key, required this.snap}) : super(key: key);

  @override
  State<UpdateProductDescriptionScreen> createState() => _UpdateProductDescriptionScreenState();
}

class _UpdateProductDescriptionScreenState extends State<UpdateProductDescriptionScreen> {
  bool _isLoading = false;
  bool _isCOD = true;
  String layout = "Tab Layout";
  String cod = "COD available";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isCOD = widget.snap['isCod'];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    TextEditingController _productTitleController = TextEditingController(text: widget.snap['productTitle']);
    TextEditingController _productDescriptionController = TextEditingController(text: widget.snap['productDescription']);
    TextEditingController _deliveryTimeController = TextEditingController(text: widget.snap['deliveryWithin']);
    TextEditingController _productDetailsController = TextEditingController(text: widget.snap['allDetails']);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Update product",
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Product Details",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.black),
              ),
              SizedBox(
                height: 16,
              ),
              TextFieldWidget(
                  text: "Product title", controller: _productTitleController),
              SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                  text: "Product Description",
                  controller: _productDescriptionController),
              SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                  text: "Product will be delivered within",
                  controller: _deliveryTimeController),
              SizedBox(
                height: 8,
              ),
              Text(
                "Cash on delivery available",
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(
                height: 8,
              ),
              InkWell(
                onTap: () {

                },
                child: Container(
                  height: 52,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          _isCOD ? "COD Available" : "COD not available",
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                      )),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Tab Layout or Details layout",
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(
                height: 8,
              ),
              InkWell(
                onTap: () {

                },
                child: Container(
                  height: 52,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          layout,
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                      )),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                  text: "Product All Details",
                  controller: _productDetailsController),
              SizedBox(
                height: 26,
              ),
              SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: FadeAnimation(
                    1.9,
                    ElevatedButton(
                      onPressed: () async {
                        if (_productTitleController.text.isEmpty) {
                          Utils().showSnackBar(
                              context, "Please Enter all the fields");
                        } else if (_productDescriptionController.text.isEmpty) {
                          Utils().showSnackBar(
                              context, "Please Enter all the fields");
                        } else if (_deliveryTimeController.text.isEmpty) {
                          Utils().showSnackBar(
                              context, "Please Enter all the fields");
                        } else if (_productDetailsController.text.isEmpty) {
                          Utils().showSnackBar(
                              context, "Please Enter all the fields");
                        } else {
                          setState(() {
                            _isLoading = true;
                          });
                          FireStoreMethods()
                              .updateDescription(
                              productId: widget.snap['productId'],
                              allDetails: _productDetailsController.text,
                              deliveryWithin: _deliveryTimeController.text,
                              isCod: _isCOD,
                              productDescription:
                              _productDescriptionController.text,
                              productTitle: _productTitleController.text)
                              .then((productId) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UpdateProductAllImages(
                                            snap: widget.snap)));
                            setState(() {
                              _isLoading = false;
                            });
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                      child: _isLoading
                          ? CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      )
                          : Text("Next".toLowerCase()),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldWidget extends StatefulWidget {
  final String text;
  final TextEditingController controller;

  const TextFieldWidget(
      {Key? key, required this.text, required this.controller})
      : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.text,
            style: TextStyle(fontSize: 12),
          ),
          SizedBox(
            height: 6,
          ),
          TextField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            controller: widget.controller,
            style: TextStyle(fontSize: 12),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
