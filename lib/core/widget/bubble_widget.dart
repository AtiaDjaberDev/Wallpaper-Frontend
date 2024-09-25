import 'package:flutter/material.dart';

class BubbleWidget extends StatelessWidget {
  const BubbleWidget({
    this.width = 200,
    this.height = 150,
    Key? key,
  }) : super(key: key);

  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: Colors.white.withOpacity(0.1)),
    );
  }
}
