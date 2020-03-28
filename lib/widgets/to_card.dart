import 'package:flutter/material.dart';

class TOCard extends StatelessWidget {
  TOCard({
    Key key,
    this.padding,
    this.margin,
    this.color,
    this.borderRadius = 10,
    this.width,
    this.height,
    this.child,
  }) : super(key: key);

  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color color;
  final double borderRadius;
  final double height;
  final double width;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(16),
      margin: margin ?? const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(blurRadius: borderRadius, color: Color(0x14959192)),
        ],
      ),
      child: child,
    );
  }
}
