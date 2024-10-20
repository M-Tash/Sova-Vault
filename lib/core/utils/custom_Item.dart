import 'dart:io'; // For working with file paths

import 'package:flutter/material.dart';

class CustomItem extends StatelessWidget {
  final String tagText;
  final String imagePath;
  final TextStyle? style;
  final double height;

  CustomItem({
    super.key,
    required this.tagText,
    required this.imagePath,
    required this.style,
    required this.height,
  });

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
          child: _loadImage(imagePath), // Dynamically load image
        ),
      ],
    );
  }

  // Method to dynamically load either asset or file image
  Widget _loadImage(String path) {
    if (path.startsWith('/data/') || path.startsWith('/storage/')) {
      // If path points to local file, use Image.file
      return Image.file(
        File(path),
        fit: BoxFit.fill,
        width: 160,
        height: height,
      );
    } else {
      // Otherwise, treat it as an asset image
      return Image.asset(
        path,
        fit: BoxFit.fill,
        width: 160,
        height: height,
      );
    }
  }
}
