import 'package:flutter/material.dart';

class CustomItem extends StatelessWidget {
  final String tagText;
  final String imagePath;
  final TextStyle? style;
  final double height;

  CustomItem(
      {super.key,
      required this.tagText,
      required this.imagePath,
      required this.style,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(tagText, style: style),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.hardEdge,
          child: Image.asset(
            imagePath,
            fit: BoxFit.fill,
            width: 160,
            height: height,
          ),
        ),
      ],
    );
  }
}
