import 'package:flutter/material.dart';

class MineInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final children = [
      _InfoItem(
        icon: Icons.format_list_bulleted,
        title: '完成订单',
        onPress: () {},
      ),
      _InfoItem(
        icon: Icons.edit,
        title: '完成订单',
        onPress: () {},
      ),
      _InfoItem(
        icon: Icons.people,
        title: '完成订单',
        onPress: () {},
      ),
      _InfoItem(
        icon: Icons.local_car_wash,
        title: '完成订单',
        onPress: () {},
      ),
    ];

    return Container(
      margin: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(3),
        boxShadow: [
          BoxShadow(blurRadius: 5, color: Color(0x14A29E9E)),
        ],
      ),
      child: Column(children: _separateList(children)),
    );
  }

  List<Widget> _separateList(List<Widget> list) {
    final children = <Widget>[];
    final div = Divider(height: 1, indent: 20);
    list.forEach((child) {
      children.addAll([child, div]);
    });
    children.removeLast();
    return children;
  }
}

class _InfoItem extends StatelessWidget {
  _InfoItem({Key key, @required this.icon, @required this.title, @required this.onPress})
      : assert(onPress != null),
        super(key: key);

  final IconData icon;
  final String title;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onPress,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: <Widget>[
              Icon(icon),
              SizedBox(width: 12),
              Expanded(
                child: Text(title),
              ),
              Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}
