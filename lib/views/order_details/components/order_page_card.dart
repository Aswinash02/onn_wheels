import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Image(
              image: AssetImage("assets/clubpoint.png"),
              height: 40,
              width: 40,
            ),
            Column(
              children: [
                Text("KTM DUKE 200"),
                Text("1500"),

              ],
            )
          ],
        ),
      ),
    );
  }
}
