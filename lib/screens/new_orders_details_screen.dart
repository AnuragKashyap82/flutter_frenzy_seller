import 'package:flutter/material.dart';
import 'package:frenzy_seller/resources/firestore_methods.dart';
import 'package:frenzy_seller/utils/utils.dart';

import '../animations/fade_animation.dart';
import '../widgets/order_progress_bar_widget.dart';

class NewOrdersDetailsScreen extends StatefulWidget {
  final snap;
  final String code;

  const NewOrdersDetailsScreen(
      {Key? key, required this.snap, required this.code})
      : super(key: key);

  @override
  State<NewOrdersDetailsScreen> createState() => _NewOrdersDetailsScreenState();
}

class _NewOrdersDetailsScreenState extends State<NewOrdersDetailsScreen> {
  bool _isLoading = false;
  int price = 1299;
  String btnText = "Order Packed";
  bool btnVisible = true;
  bool isEnabled = true;

  @override
  Widget build(BuildContext context) {
    setState(() {
      price = int.parse(widget.snap['productPrice']) *
          int.parse(widget.snap['quantity']);
    });

    if (widget.code == "1") {
      setState(() {
        btnText = "Order Packed";
      });
    } else if (widget.code == "2") {
      setState(() {
        btnText = "Order Shipped";
      });
    } else if (widget.code == "3") {
      setState(() {
        btnVisible = false;
      });
    } else if (widget.code == "4") {
      setState(() {
        btnText = "Order Delivered";
      });
    } else if (widget.code == "5") {
      setState(() {
        btnVisible = false;
      });
    } else if (widget.code == "6") {
      setState(() {
        btnText = "Refunded";
      });
    } else if (widget.code == "7") {
      setState(() {
        btnVisible = false;
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Order Details",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Order ID: ${widget.snap['orderId']}",
                style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
              ),
            ),
            Divider(
              height: 0.2,
              color: Colors.grey.shade400,
            ),
            ProductDetailsWidget(snap: widget.snap),
            Divider(
              height: 0.2,
              color: Colors.grey.shade400,
            ),
            SizedBox(
              height: 400,
              child: OrderProgressBarWidget(snap: widget.snap),
            ),
            Divider(
              height: 0.2,
              color: Colors.grey.shade400,
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: PhysicalModel(
                color: Colors.white,
                shadowColor: Colors.blue,
                elevation: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "SHIPPING DETAILS",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black54,
                            letterSpacing: 0.5),
                      ),
                    ),
                    Divider(
                      color: Colors.grey.shade400,
                      height: 0.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Text(
                        "${widget.snap['name']}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: Text(
                        "${widget.snap['shippingAddress']}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Text(
                        "${widget.snap['phoneNo']}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: PhysicalModel(
                color: Colors.white,
                shadowColor: Colors.blue,
                elevation: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Text(
                        "Price Details",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey.shade400,
                      height: 0.3,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Original Price",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w100),
                          ),
                          Text(
                            "Rs.${widget.snap['originalPrice']}",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Price",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                          Text(
                            "Rs.${price.toString()}",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Delivery Charges",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                          Text(
                            "Rs.${widget.snap['deliveryFee']}",
                            style: TextStyle(fontSize: 14, color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Discount",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                          Text(
                            "Rs.${widget.snap['discount']}",
                            style: TextStyle(fontSize: 14, color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Divider(
                      color: Colors.grey.shade400,
                      height: 0.3,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Amount",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            "Rs.${widget.snap['purchasedPrice']}",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Divider(
                      color: Colors.grey.shade400,
                      height: 0.3,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "You saved Rs.${widget.snap['discount']} on this order",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.green),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: PhysicalModel(
                color: Colors.white,
                shadowColor: Colors.blue,
                elevation: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "PAYMENT DETAILS",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                            letterSpacing: 0.5),
                      ),
                    ),
                    Divider(
                      color: Colors.grey.shade400,
                      height: 0.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Text(
                        "COD: Rs. ${widget.snap['purchasedPrice']} to be paid",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    )
                  ],
                ),
              ),
            ),
            btnVisible
                ? Padding(
                    padding: const EdgeInsets.all(26),
                    child: SizedBox(
                        width: double.infinity,
                        height: 46,
                        child: FadeAnimation(
                          1.7,
                          ElevatedButton(
                              onPressed: () async {
                                if (widget.code == "1") {
                                  _markOrderStatusPackedDialog();
                                } else if (widget.code == "2") {
                                  _markOrderStatusShippedDialog();
                                }else if (widget.code == "4") {
                                  _markOrderStatusDeliveredDialog();
                                }else if (widget.code == "6") {
                                  _markOrderStatusRefundedDialog();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: StadiumBorder()),
                              child: _isLoading
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      btnText,
                                      style: TextStyle(
                                          fontSize: 12, letterSpacing: 0.5),
                                    )),
                        )),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
  bool _loading = false;
  void _markOrderStatusPackedDialog() {

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          contentPadding:
          EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 20),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              const Icon(
                Icons.logout,
                color: Colors.blue,
              ),
              const Text("   Order Packed")
            ],
          ),
          content: Text(
            "Are you sure want to mark this order packed?",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
            ),
            MaterialButton(
              onPressed: () async {
                setState(() {
                  _loading = true;
                });
                FireStoreMethods()
                    .markOrderStatusPacked(
                    orderBy: widget.snap['orderBy'],
                    orderId: widget.snap['orderId'],
                    orderFrom: widget.snap['orderFrom']
                )
                    .then((value) {
                      setState(() {
                        _loading = false;
                      });
                  Utils().showSnackBar(context, "Order Packed!!!");
                  Navigator.pop(context);
                  Navigator.pop(context);
                });
              },
              child: _loading ? CircularProgressIndicator(strokeWidth: 1, color: Colors.blue,) : Text(
                "Packed",
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
            )
          ],
        ));
  }

  void _markOrderStatusShippedDialog() {

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          contentPadding:
          EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 20),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              const Icon(
                Icons.logout,
                color: Colors.blue,
              ),
              const Text("   Order Shipped")
            ],
          ),
          content: Text(
            "Are you sure want to mark this order shipped?",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
            ),
            MaterialButton(
              onPressed: () async {
                setState(() {
                  _loading = true;
                });
                FireStoreMethods()
                    .markOrderStatusShipped(
                    orderBy: widget.snap['orderBy'],
                    orderId: widget.snap['orderId'],
                    orderFrom: widget.snap['orderFrom']
                )
                    .then((value) {
                  setState(() {
                    _loading = false;
                  });
                  Utils().showSnackBar(context, "Order Shipped!!!");
                  Navigator.pop(context);
                  Navigator.pop(context);
                });
              },
              child: _loading ? CircularProgressIndicator(strokeWidth: 1, color: Colors.blue,) : Text(
                "Shipped",
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
            )
          ],
        ));
  }

  void _markOrderStatusDeliveredDialog() {

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          contentPadding:
          EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 20),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              const Icon(
                Icons.logout,
                color: Colors.blue,
              ),
              const Text("   Order Delivered")
            ],
          ),
          content: Text(
            "Are you sure want to mark this order delivered?",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
            ),
            MaterialButton(
              onPressed: () async {
                setState(() {
                  _loading = true;
                });
                FireStoreMethods()
                    .markOrderStatusDelivered(
                    orderBy: widget.snap['orderBy'],
                    orderId: widget.snap['orderId'],
                    orderFrom: widget.snap['orderFrom']
                )
                    .then((value) {
                  setState(() {
                    _loading = false;
                  });
                  Utils().showSnackBar(context, "Order delivered!!!");
                  Navigator.pop(context);
                  Navigator.pop(context);
                });
              },
              child: _loading ? CircularProgressIndicator(strokeWidth: 1, color: Colors.blue,) : Text(
                "Delivered",
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
            )
          ],
        ));
  }

  void _markOrderStatusRefundedDialog() {

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          contentPadding:
          EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 20),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              const Icon(
                Icons.logout,
                color: Colors.blue,
              ),
              const Text("   Amount Refunded")
            ],
          ),
          content: Text(
            "Are you sure want to mark this Amount Refunded?",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
            ),
            MaterialButton(
              onPressed: () async {
                setState(() {
                  _loading = true;
                });
                FireStoreMethods()
                    .markOrderStatusRefunded(
                    orderBy: widget.snap['orderBy'],
                    orderId: widget.snap['orderId'],
                    orderFrom: widget.snap['orderFrom']
                )
                    .then((value) {
                  setState(() {
                    _loading = false;
                  });
                  Utils().showSnackBar(context, "Order Refunded!!!");
                  Navigator.pop(context);
                  Navigator.pop(context);
                });
              },
              child: _loading ? CircularProgressIndicator(strokeWidth: 1, color: Colors.blue,) : Text(
                "Refunded",
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
            )
          ],
        ));
  }
}

class ProductDetailsWidget extends StatefulWidget {
  final snap;

  const ProductDetailsWidget({Key? key, required this.snap}) : super(key: key);

  @override
  State<ProductDetailsWidget> createState() => _ProductDetailsWidgetState();
}

class _ProductDetailsWidgetState extends State<ProductDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.snap['productTitle']}",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "${widget.snap['productDescription']}",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Seller: Shop Name to be integrated",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Rs.${widget.snap['purchasedPrice']}",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.green.shade700, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          "Qty: ${widget.snap['quantity']}",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 26,
          ),
          Center(
              child: Image.network(
            "${widget.snap['productImage']}",
            width: 100,
            height: 120,
          ))
        ],
      ),
    );
  }
}
