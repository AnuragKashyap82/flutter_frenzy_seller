import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:frenzy_seller/update_product_screen/update_product_description_screen.dart';

import '../animations/fade_animation.dart';
import '../resources/firestore_methods.dart';
import '../utils/utils.dart';

class UpdateProductDetailsScreen extends StatefulWidget {
  final snap;
  const UpdateProductDetailsScreen({Key? key, required this.snap}) : super(key: key);

  @override
  State<UpdateProductDetailsScreen> createState() => _UpdateProductDetailsScreenState();
}

class _UpdateProductDetailsScreenState extends State<UpdateProductDetailsScreen> {
  Uint8List? image;
  String productImage = "";
  bool _isUploading = false;
  bool _isLoading = false;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productImage = widget.snap['productImage'];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    TextEditingController _skuIdController = TextEditingController();
    TextEditingController _productCuttedPriceController = TextEditingController(text: widget.snap['productCuttedPrice']);
    TextEditingController _productPriceController = TextEditingController(text: widget.snap['productPrice']);
    TextEditingController _stocksController = TextEditingController(text: widget.snap['deliveryFee']);
    TextEditingController _deliveryFeeController = TextEditingController(text: widget.snap['noOfQuantity']);
    TextEditingController _procrumentController = TextEditingController();
    TextEditingController _fulfilmentController = TextEditingController();
    TextEditingController _zonalController = TextEditingController();
    TextEditingController _nationalController = TextEditingController();
    TextEditingController _countryController = TextEditingController();
    TextEditingController _manuDetailsController = TextEditingController();
    TextEditingController _packerDetailsController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Update product",
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Font View",
                style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(26),
                ),
                child:
                image != null
                    ? Image.memory(image!):
                   Image.network(widget.snap['productImage']),
              ),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: FadeAnimation(
                    1.9,
                    ElevatedButton(
                      onPressed: () async {
                        Uint8List? temp = await Utils().pickImage();
                        if (temp != null) {
                          setState(() {
                            image = temp;
                          });
                        }
                        setState(() {
                          _isUploading = true;
                        });
                        if (image != null) {
                          FireStoreMethods()
                              .uploadProductImage(image: image!)
                              .then((value) {
                            setState(() {
                              productImage = value;
                              _isUploading = false;
                              Utils().showSnackBar(context, productImage);
                            });
                          });
                        } else {
                          Utils().showSnackBar(context, "Pick image !!!");
                        }
                      },
                      style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                      child: _isUploading
                          ? CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      )
                          : Text("upload Image".toLowerCase()),
                    ),
                  )),
              SizedBox(
                height: 12,
              ),
              const Text(
                "Follow Image Guidelines to reduce the Quality Check faliure",
                style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Image Guidelines",
                style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Use clear color image with minimum resolution of 500 * 500 px.",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Check the sample to ensure provided the correct image View.",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFieldWidget(
                  text: "Select SKU ID", controller: _skuIdController),
              SizedBox(
                height: 16,
              ),
              Text(
                "Price Details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              SizedBox(
                height: 16,
              ),
              TextFieldWidget(
                  text: "MRP", controller: _productCuttedPriceController),
              SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                  text: "Your Selling Price",
                  controller: _productPriceController),
              SizedBox(
                height: 16,
              ),
              Text(
                "Inventory Details",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.black),
              ),
              SizedBox(
                height: 16,
              ),
              TextFieldWidget(
                  text: "Fulfilment By", controller: _fulfilmentController),
              SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                  text: "Procurement Type", controller: _procrumentController),
              SizedBox(
                height: 8,
              ),
              TextFieldWidget(text: "Stocks", controller: _stocksController),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Delivery Charges to customer",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              TextFieldWidget(
                  text: "Local Delivery Charges",
                  controller: _deliveryFeeController),
              SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                  text: "Zonal Delivery Charges", controller: _zonalController),
              SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                  text: "National Delivery Charges",
                  controller: _nationalController),
              SizedBox(
                height: 16,
              ),
              Text(
                "Manufacturing Details",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.black),
              ),
              SizedBox(
                height: 16,
              ),
              TextFieldWidget(
                  text: "Country of origin", controller: _countryController),
              SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                  text: "Manufactures Details",
                  controller: _manuDetailsController),
              SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                  text: "Packer Details", controller: _packerDetailsController),
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
                        if (_deliveryFeeController.text.isEmpty) {
                          Utils().showSnackBar(context, "Enter all fields!!!");
                        } else if (_productCuttedPriceController.text.isEmpty) {
                          Utils().showSnackBar(context, "Enter all fields!!!");
                        } else if (productImage.isEmpty) {
                          Utils().showSnackBar(context, "Enter all fields!!!");
                        } else if (_productPriceController.text.isEmpty) {
                          Utils().showSnackBar(context, "Enter all fields!!!");
                        } else if (_stocksController.text.isEmpty) {
                          Utils().showSnackBar(context, "Enter all fields!!!");
                        } else {
                          setState(() {
                            _isLoading = true;
                          });
                          FireStoreMethods()
                              .updateProduct(
                            deliveryFee: _deliveryFeeController.text,
                            productCuttedPrice:
                            _productCuttedPriceController.text,
                            productImage: productImage,
                            productPrice: _productPriceController.text,
                            stocks: _stocksController.text,
                            productId: widget.snap['productId']
                          )
                              .then((productId) {
                            setState(() {
                              _isLoading = false;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UpdateProductDescriptionScreen(
                                            snap: widget.snap)));
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
