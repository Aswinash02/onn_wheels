import 'package:flutter/material.dart';
import 'package:onnwheels/utils/image_directory.dart';

class CardWidget extends StatelessWidget {
  const CardWidget(
      {super.key,
      required this.imageDirectory,
      required this.mainText,
      required this.subText});

  final String imageDirectory;
  final String mainText;
  final String subText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: 160,
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(15)),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imageDirectory,
                height: 30,
                width: 30,
              ),
              Text(
                mainText,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(subText,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 8))
            ],
          ),
        ),
      ),
    );
  }
}
