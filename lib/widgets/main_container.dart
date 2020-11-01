import 'package:flutter/material.dart';

class MainContainer extends StatelessWidget {
  MainContainer({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).primaryColor,
            Color(0xFFF7F7FF),
            Color(0xFFF7F7FF),
          ],
          stops: [0, 0.33, 1],
        ),
      ),
      child: child,
    );
  }
}
