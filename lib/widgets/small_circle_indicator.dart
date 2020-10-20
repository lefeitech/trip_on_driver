import 'package:flutter/material.dart';

class SmallCircleIndicator extends StatelessWidget {

  SmallCircleIndicator({this.color, this.size, this.drawWidth, this.padding});
  final Color color;
  final double size;
  final double drawWidth;
  final EdgeInsetsGeometry padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size ?? 30,
      height: size ?? 30,
      padding: padding ?? const EdgeInsets.all(4),
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(color ?? Colors.white),
        strokeWidth: drawWidth ?? 4,
      ),
    );
  }
}