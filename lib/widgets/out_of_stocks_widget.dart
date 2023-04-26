import 'package:flutter/material.dart';

class OutOfStockWidget extends StatefulWidget {
  final snap;

  const OutOfStockWidget({Key? key, required this.snap}) : super(key: key);

  @override
  State<OutOfStockWidget> createState() => _OutOfStockWidgetState();
}

class _OutOfStockWidgetState extends State<OutOfStockWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    widget.snap['productTitle'],
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Out Of Stock",
                    style: TextStyle(
                        fontSize: 12, fontWeight: FontWeight.normal, color: Colors.red),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Image.network(
                  widget.snap['productImage'],
                  width: 60,
                  height: 120,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Divider(height: 1, thickness: 0.5, color: Colors.grey.shade400,)
      ],
    );
  }
}
