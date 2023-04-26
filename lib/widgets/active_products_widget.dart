import 'package:flutter/material.dart';
import 'package:frenzy_seller/screens/product_details_screen.dart';

class ActiveProductWidget extends StatefulWidget {
  final snap;

  const ActiveProductWidget({Key? key, required this.snap}) : super(key: key);

  @override
  State<ActiveProductWidget> createState() => _ActiveProductWidgetState();
}

class _ActiveProductWidgetState extends State<ActiveProductWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Image.network(
                widget.snap['productImage'],
                width: 60,
                height: 120,
              ),
              SizedBox(
                width: 16,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Category:",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        widget.snap['category'],
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text(
                        "Brand:",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Frenzy",
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text(
                        "Processed On:",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "${widget.snap['processedDate']} - ${widget.snap['processedTime']}",
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Divider(
          height: 1,
          color: Colors.grey.shade300,
          thickness: 0.5,
        )
      ],
    );
  }
}
