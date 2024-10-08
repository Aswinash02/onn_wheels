import 'package:flutter/material.dart';
import 'package:onnwheels/mytheme.dart';
import 'package:shimmer/shimmer.dart';

class CategorySimmer extends StatelessWidget {
  const CategorySimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10, mainAxisSpacing: 10, crossAxisCount: 2),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    color: MyTheme.white,
                    borderRadius: BorderRadius.circular(8)),
              ),
            );
          }),
    );
  }
}
