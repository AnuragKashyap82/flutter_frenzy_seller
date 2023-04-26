import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frenzy_seller/screens/all_oredrs_screen.dart';
import 'package:frenzy_seller/screens/cancelled_orders_screen.dart';
import 'package:frenzy_seller/screens/delivered_orders_screen.dart';
import 'package:frenzy_seller/screens/login_screen.dart';
import 'package:frenzy_seller/screens/my_products_screen.dart';
import 'package:frenzy_seller/screens/new_order_screen.dart';
import 'package:frenzy_seller/screens/out_for_delivery_order_screen.dart';
import 'package:frenzy_seller/screens/out_of_stocks_products.dart';
import 'package:frenzy_seller/screens/packed_order_screen.dart';
import 'package:frenzy_seller/screens/refunded_orders_screen.dart';
import 'package:frenzy_seller/screens/returened_orders_screen.dart';
import 'package:frenzy_seller/screens/shipped_orders_screen.dart';

import '../animations/fade_animation.dart';
import '../utils/utils.dart';
import '../widgets/reco_product_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;
  var _sellerData = {};
  int newOrders = 0;
  int packedOrders = 0;
  int cancelledOrders = 0;
  int shippedOrders = 0;
  int deliveredOrders = 0;
  int returnedOrders = 0;
  int refundedOrders = 0;

  final CollectionReference collectionRef = FirebaseFirestore.instance
      .collection('sellers')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection("orders");

  void getNewOrdersCount() {
    final Query ordered =
    collectionRef.where('orderStatus', isEqualTo: 'ordered');

    final Query packed =
    collectionRef.where('orderStatus', isEqualTo: 'packed');

    final Query cancelled =
    collectionRef.where('orderStatus', isEqualTo: 'cancelled');

    final Query shipped =
    collectionRef.where('orderStatus', isEqualTo: 'shipped');

    final Query delivered =
    collectionRef.where('orderStatus', isEqualTo: 'delivered');

    final Query returned =
    collectionRef.where('orderStatus', isEqualTo: 'returned');

    final Query refunded =
    collectionRef.where('orderStatus', isEqualTo: 'refunded');

    ordered.get().then((QuerySnapshot snapshot) {
      newOrders = snapshot.size;

    });
    packed.get().then((QuerySnapshot snapshot) {
      packedOrders = snapshot.size;

    });
    cancelled.get().then((QuerySnapshot snapshot) {
      cancelledOrders = snapshot.size;

    });
    shipped.get().then((QuerySnapshot snapshot) {
      shippedOrders = snapshot.size;

    });
    delivered.get().then((QuerySnapshot snapshot) {
      deliveredOrders = snapshot.size;

    });
    returned.get().then((QuerySnapshot snapshot) {
      returnedOrders = snapshot.size;

    });
    refunded.get().then((QuerySnapshot snapshot) {
      refundedOrders = snapshot.size;
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUserDetails();
    getNewOrdersCount();
  }

  void loadUserDetails() async {
    try {
      var sellerSnap = await FirebaseFirestore.instance
          .collection("sellers")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
      if (sellerSnap.exists) {
        setState(() {
          _sellerData = sellerSnap.data()!;
        });
      } else {}
    } catch (e) {
      Utils().showSnackBar(context, e.toString());
    }
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
        backgroundColor: Colors.blue,
        elevation: 0,
        actions: [
          InkWell(
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Icon(Icons.search),
              )),
        ],
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          children: [
            DrawerHeader(
              padding:
                  const EdgeInsets.only(top: 22, left: 8, right: 8, bottom: 8),
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 34,
                      backgroundImage:
                          NetworkImage("${_sellerData['photoUrl']}"),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "${_sellerData['shopName']}",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "${_sellerData['email']}",
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                leading: const Icon(
                  Icons.shopping_bag,
                  color: Colors.black87,
                ),
                title: const Text(
                  'My Frenzy',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                leading: const Icon(
                  Icons.category,
                  color: Colors.black87,
                ),
                title: const Text(
                  'All Category',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                leading: const Icon(
                  Icons.add_chart_sharp,
                  color: Colors.black87,
                ),
                title: const Text(
                  'Add Category',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                leading: const Icon(
                  Icons.store_outlined,
                  color: Colors.black87,
                ),
                title: const Text(
                  'Trending Store',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                leading: const Icon(
                  Icons.add_shopping_cart_sharp,
                  color: Colors.black87,
                ),
                title: const Text(
                  'My Products',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => MyProductScreen()));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                leading: const Icon(
                  Icons.account_balance_wallet,
                  color: Colors.black87,
                ),
                title: const Text(
                  'Sell on frenzy store',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                leading: const Icon(
                  Icons.surround_sound,
                  color: Colors.black87,
                ),
                title: const Text(
                  'Refer & Earn',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                leading: const Icon(
                  Icons.shopping_bag,
                  color: Colors.black87,
                ),
                title: const Text(
                  'Orders',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => AllOrdersScreen()));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                leading: const Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.black87,
                ),
                title: const Text(
                  'Out Of Stocks',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OutOfStocksProducts()));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                leading: const Icon(
                  Icons.card_giftcard,
                  color: Colors.black87,
                ),
                title: const Text(
                  'My Rewards',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                leading: const Icon(
                  Icons.shopping_cart,
                  color: Colors.black87,
                ),
                title: const Text(
                  'My Cart',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                leading: const Icon(
                  Icons.favorite,
                  color: Colors.black87,
                ),
                title: const Text(
                  'My Wishlist',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                leading: const Icon(
                  Icons.person,
                  color: Colors.black87,
                ),
                title: const Text(
                  'My Account',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                leading: const Icon(
                  Icons.logout,
                  color: Colors.black87,
                ),
                title: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {
                  _addChatUserDialog();
                },
              ),
            ),
          ],
        ),
      ),
      body: _isLoading ? Center(child: CircularProgressIndicator(strokeWidth: 2,)):
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${_sellerData['shopName']} all Activity",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(
                height: 26,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => NewOrderScreen()));
                    },
                    child: PhysicalModel(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      elevation: 7,
                      shadowColor: Colors.blue.shade100,
                      child: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width / 2 - 20,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "New Orders",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87),
                                ),
                                Text(
                                  " \n( $newOrders ) ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.green),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => PackedOrdersScreen()));
                    },
                    child: PhysicalModel(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      elevation: 7,
                      shadowColor: Colors.blue.shade100,
                      child: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width / 2 - 20,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Packed Orders",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87),
                                ),
                                Text(
                                  " \n( $packedOrders ) ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => CancelledOrdersScreen()));
                    },
                    child: PhysicalModel(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      elevation: 7,
                      shadowColor: Colors.blue.shade100,
                      child: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width / 2 - 20,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Cancelled Orders",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87),
                                ),
                                Text(
                                  " \n( $cancelledOrders ) ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ShippedOrdersScreen()));
                    },
                    child: PhysicalModel(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      elevation: 7,
                      shadowColor: Colors.blue.shade100,
                      child: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width / 2 - 20,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Shipped Orders",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87),
                                ),
                                Text(
                                  " \n( $shippedOrders ) ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => OutForDeliveryScreen()));
                    },
                    child: PhysicalModel(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      elevation: 7,
                      shadowColor: Colors.blue.shade100,
                      child: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width / 2 - 20,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Out For Delivery",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87),
                                ),
                                Text(
                                  " \n( To be integrated ) ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => DeliveredOrdersScreen()));
                    },
                    child: PhysicalModel(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      elevation: 7,
                      shadowColor: Colors.blue.shade100,
                      child: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width / 2 - 20,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Delivered Orders",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87),
                                ),
                                Text(
                                  " \n( $deliveredOrders ) ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.green),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ReturnedOrdersScreen()));
                    },
                    child: PhysicalModel(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      elevation: 7,
                      shadowColor: Colors.blue.shade100,
                      child: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width / 2 - 20,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Returned Orders",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87),
                                ),
                                Text(
                                  " \n( $returnedOrders ) ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => RefundedOrdersScreen()));
                    },
                    child: PhysicalModel(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      elevation: 7,
                      shadowColor: Colors.blue.shade100,
                      child: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width / 2 - 20,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Refunded Orders",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87),
                                ),
                                Text(
                                  " \n( $refundedOrders ) ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 26,
              ),
              Text(
                "${_sellerData['shopName']} all Products",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("products")
                          .where("shopId",
                              isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (!snapshot.hasData) {
                          return Container();
                        }
                        return GridView.builder(
                          itemCount: snapshot.data!.docs.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          primary: false,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, mainAxisExtent: 200),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              child: FadeAnimation(
                                1.1,
                                RecoProductWidget(
                                  snap: snapshot.data!.docs[index].data(),
                                ),
                              ),
                            );
                          },
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addChatUserDialog() {
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
                  const Text("  Logout")
                ],
              ),
              content: Text(
                "Are you sure want to logout?",
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
                    FirebaseAuth.instance.signOut().then((value) => {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()))
                        });
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Logout",
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                )
              ],
            ));
  }
}
