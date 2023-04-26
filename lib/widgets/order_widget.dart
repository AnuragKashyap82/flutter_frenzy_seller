import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frenzy_seller/screens/new_orders_details_screen.dart';
import 'package:frenzy_seller/screens/order_details_screen.dart';

import '../utils/utils.dart';

class OrdersWidget extends StatefulWidget {
  final snap;
  final String code;
  const OrdersWidget({Key? key, required this.snap, required this.code}) : super(key: key);

  @override
  State<OrdersWidget> createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends State<OrdersWidget> {

  bool _isLoading = false;
  var _orderData = {};

  bool _isOrdered = false;
  bool _isPacked = false;
  bool _isShipped = false;
  bool _isDelivered = false;
  bool _isCancelled = false;
  bool _isReturned = false;
  bool _isRefunded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _isLoading = true;
    });
    loadUserDetails();
    if (widget.snap['orderStatus'] == "ordered") {
      setState(() {
        _isOrdered = true;
      });
    } else if (widget.snap['orderStatus'] == "packed") {
      setState(() {
        _isPacked = true;
      });
    } else if (widget.snap['orderStatus'] == "shipped") {
      setState(() {
        _isShipped = true;
      });
    } else if (widget.snap['orderStatus'] == "delivered") {
      setState(() {
        _isDelivered = true;
      });
    } else if (widget.snap['orderStatus'] == "cancelled") {
      setState(() {
        _isCancelled = true;
      });
    } else if (widget.snap['orderStatus'] == "returned") {
      setState(() {
        _isReturned = true;
      });
    } else if (widget.snap['orderStatus'] == "refunded") {
      setState(() {
        _isRefunded = true;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void loadUserDetails() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var orderSnap = await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.snap['orderBy'])
      .collection("MyOrders")
      .doc(widget.snap['orderId'])
          .get();
      if (orderSnap.exists) {
        setState(() {
          _orderData = orderSnap.data()!;
        });
      } else {}
      setState(() {});
    } catch (e) {
      Utils().showSnackBar(context, e.toString());
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return
    _isLoading ? Center(child: CircularProgressIndicator(strokeWidth: 1, color: Colors.blue,)):
      GestureDetector(
        onTap: () {
          if(widget.code == "1"){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => OrderDetailsScreen(snap: _orderData)));
          }else if(widget.code == "2"){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => NewOrdersDetailsScreen(snap: _orderData, code: "1",)));
          }else if(widget.code == "3"){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => NewOrdersDetailsScreen(snap: _orderData, code: "2",)));
          }else if(widget.code == "3"){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => NewOrdersDetailsScreen(snap: _orderData, code: "2",)));
          }else if(widget.code == "4"){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => NewOrdersDetailsScreen(snap: _orderData, code: "3",)));
          }else if(widget.code == "5"){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => NewOrdersDetailsScreen(snap: _orderData, code: "4",)));
          }else if(widget.code == "7"){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => NewOrdersDetailsScreen(snap: _orderData, code: "5",)));
          }else if(widget.code == "8"){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => NewOrdersDetailsScreen(snap: _orderData, code: "6",)));
          }else if(widget.code == "9"){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => NewOrdersDetailsScreen(snap: _orderData, code: "7",)));
          }

        },
        child: PhysicalModel(
        color: Colors.white,
        elevation: 7,
        shadowColor: Colors.pinkAccent,
        borderRadius: BorderRadius.circular(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${_orderData['productTitle']}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.green
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          _isOrdered ?
                          Text(
                            "Order has been placed on ${widget.snap['orderDate']}  ${widget.snap['orderTime']}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.black54,),
                          ) :_isPacked ?
                          Text(
                            "Order has been packed on ${widget.snap['orderPackedDate']}   ${widget.snap['orderPackedTime']}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.black54,),
                          ) :_isShipped ?
                          Text(
                            "Order has been shipped on ${widget.snap['orderShippedDate']}   ${widget.snap['orderShippedTime']}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.black54,),
                          ):_isDelivered ?
                          Text(
                            "Order has been delivered on ${widget.snap['orderDeliveredDate']}   ${widget.snap['orderDeliveredTime']}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.black54,),
                          ):_isCancelled ?
                          Text(
                            "Order has been cancelled on ${widget.snap['orderCancelledDate']}   ${widget.snap['orderCancelledTime']}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.black54,),
                          ):_isReturned ?
                          Text(
                            "Order has been returned on ${widget.snap['orderReturnedDate']}   ${widget.snap['orderReturnedTime']}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.black54,),
                          ):_isRefunded ?
                          Text(
                            "Amount has been refunded on ${widget.snap['orderRefundedDate']}   ${widget.snap['orderRefundedTime']}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.black54,),
                          ): Container(),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: Text(
                          "Order date: ${_orderData['orderDate']}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w100,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 42,
                    backgroundImage: NetworkImage("${_orderData['productImage']}"),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Divider(height: 1, color: Colors.grey.shade400, thickness: 0.4,)
          ],
        ),
    ),
      );
  }
}
