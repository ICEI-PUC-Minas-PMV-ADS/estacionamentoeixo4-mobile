import 'package:flutter/material.dart';

class ImageBox extends StatelessWidget {
  final String imagePath;
  final bool isSelected;

  const ImageBox(this.imagePath, this.isSelected);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFF262626) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Image.asset(
        imagePath,
        height: 50,
        width: 90,
      ),
    );
  }
}
