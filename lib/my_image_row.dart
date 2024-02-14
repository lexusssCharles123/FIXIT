import 'package:flutter/material.dart';
import 'my_image_box.dart';

class MyImageRow extends StatelessWidget {
  final List<String> firstImage;
  final List<String> secondImage;
  final List<String> thirdImage;
  final double textFontSize; // New parameter for text font size

  const MyImageRow({
    Key? key,
    required this.firstImage,
    required this.secondImage,
    required this.thirdImage,
    required this.textFontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyImageBox(firstImage[0], firstImage[1], textFontSize: textFontSize),
        const SizedBox(width: 20),
        MyImageBox(secondImage[0], secondImage[1], textFontSize: textFontSize),
        const SizedBox(width: 20),
        MyImageBox(thirdImage[0], thirdImage[1], textFontSize: textFontSize),
      ],
    );
  }
}
