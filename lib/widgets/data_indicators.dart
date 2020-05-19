import 'package:flutter/material.dart';

// 没有数据指示
class NoDataWidget extends StatelessWidget {
  final bool isFullPage;
  final bool isSliver;

  NoDataWidget({this.isFullPage = false, this.isSliver = false});

  @override
  Widget build(context) {
    Color color = Colors.grey;
    String text = 'No data for now';

    Widget inline = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[Icon(Icons.inbox, color: color), Text(text, style: TextStyle(color: color))],
    );

    Widget block = SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.inbox, size: 80, color: color),
            Text(text, style: TextStyle(color: color)),
          ],
        ));

    Widget child = isFullPage ? block : inline;
    return isSliver ? SliverToBoxAdapter(child: child) : child;
  }
}

// 数据加载错误指示
class LoadErrorWidget extends StatelessWidget {
  LoadErrorWidget({
    this.isFullPage = false,
    this.isSliver = false,
    this.refreshFn,
  }) : assert(refreshFn != null);

  final bool isFullPage;
  final bool isSliver;
  final Function refreshFn;

  @override
  Widget build(context) {
    Color color = Colors.grey;
    String text = 'Load data error, tap to retry';

    Widget inline = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[Icon(Icons.refresh, color: color), Text(text, style: TextStyle(color: color))],
    );

    Widget block = SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.refresh, size: 80, color: color),
            Text(text, style: TextStyle(color: color)),
          ],
        ));

    Widget child = isFullPage ? block : inline;
    child = GestureDetector(behavior: HitTestBehavior.translucent, onTap: refreshFn, child: child);

    return isSliver ? SliverToBoxAdapter(child: child) : child;
  }
}

class LoadingWidget extends StatelessWidget {
  LoadingWidget({this.isFullPage = false, this.isSliver = false});

  final bool isFullPage;
  final bool isSliver;

  @override
  Widget build(context) {
    Color color = Colors.grey;
    String text = 'loading';

    Widget inline = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(padding: EdgeInsets.only(right: 10), child: CircularProgressIndicator()),
        Text(text, style: TextStyle(color: color))
      ],
    );

    Widget block = SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: 40, height: 40, child: CircularProgressIndicator()),
            Text(text, style: TextStyle(color: color)),
          ],
        ));

    Widget child = isFullPage ? block : inline;
    return isSliver ? SliverToBoxAdapter(child: child) : child;
  }
}
