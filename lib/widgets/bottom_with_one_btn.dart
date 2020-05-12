import 'package:flutter/material.dart';

class BottomWithOneBtn extends StatelessWidget {
  BottomWithOneBtn({Key key, this.onPress, @required this.child, this.padding})
      : assert(child != null),
        super(key: key);

  final VoidCallback onPress;
  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
        child: FlatButton(
          onPressed: onPress ?? () {},
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          child: child,
        ),
      ),
    );
  }
}
