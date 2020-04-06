import 'package:flutter/material.dart';

class GradientIcon extends StatelessWidget {
  GradientIcon({Key key, @required this.icon, this.iconSize, this.gradient});

  final IconData icon;
  final Gradient gradient;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return gradient == null
        ? icon
        : ShaderMask(
            shaderCallback: (Rect bounds) => gradient.createShader(Offset.zero & bounds.size),
            child: Icon(icon, size: iconSize, color: Colors.white),
          );
  }
}
