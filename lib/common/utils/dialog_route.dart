import 'package:flutter/material.dart';

class DialogRoute<T> extends PopupRoute<T> {
  final bool barrierDismissible;
  final Color barrierColor;
  final Duration transitionDuration;

  final RoutePageBuilder dialogBuilder;
  final RouteTransitionsBuilder transitionBuilder;

  DialogRoute({
    @required this.dialogBuilder,
    this.barrierDismissible = true,
    this.barrierColor = const Color(0x88000000),
    this.transitionDuration = const Duration(milliseconds: 288),
    this.transitionBuilder,
  });

  @override
  String get barrierLabel => "dialog_route";

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return dialogBuilder(context, animation, secondaryAnimation);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (transitionBuilder == null) {
      return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.linear,
          ),
          child: child);
    } // Some default transition
    return transitionBuilder(context, animation, secondaryAnimation, child);
  }

  @override
  bool get opaque => false;
}
