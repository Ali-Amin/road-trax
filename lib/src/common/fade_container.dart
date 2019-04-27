import 'package:flutter/material.dart';

class FadeBox extends StatelessWidget {
  final Animation<double> containerGrowAnimation;
  final Animation<Color> fadeScreenAnimation;
  FadeBox({this.containerGrowAnimation, this.fadeScreenAnimation});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Hero(
      tag: "fade",
      child: Container(
        width: containerGrowAnimation.value < 1 ? width : 0.0,
        height: containerGrowAnimation.value < 1 ? height : 0,
        decoration: BoxDecoration(
          color: fadeScreenAnimation.value,
        ),
      ),
    );
  }
}
