import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OrderCardListViewSimmer extends StatelessWidget {
  const OrderCardListViewSimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // Show a fixed number of shimmer placeholders
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Container(
                    height: 80,
                    width: 90,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 16,
                        width: 100,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 20,
                        width: 80,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 18,
                        width: 60,
                        color: Colors.white,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
