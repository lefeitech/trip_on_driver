import 'package:driver/common/style/custom_theme.dart';
import 'package:driver/widgets/start_arrive_widget.dart';
import 'package:driver/widgets/to_card.dart';
import 'package:flutter/material.dart';

class OrderListItem extends StatelessWidget {
  OrderListItem({Key key, this.onTap});

  final VoidCallback onTap;
  final _bodyFontColor = Color(0xFFA2A0A0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: TOCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // order title / time / no.
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('接机', style: Theme.of(context).textTheme.subtitle.copyWith(fontSize: 18)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      const SizedBox(height: 10),
                      Text('2020-03-01 08:24', style: TextStyle(color: _bodyFontColor, fontSize: 12)),
                      const SizedBox(height: 2),
                      Text('No.009620200301', style: TextStyle(color: _bodyFontColor, fontSize: 10)),
                    ],
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 6, bottom: 6, right: 10),
                  child: Icon(Icons.cloud_circle, color: _bodyFontColor, size: 20),
                ),
                Text(' AE86E86 航班实际到达后用车', style: TextStyle(color: _bodyFontColor, fontSize: 12)),
              ],
            ),
            // start point and arrive point
            StartArriveWidget(title: '吉隆坡国际机场（吉隆坡）'),
            StartArriveWidget(title: '马来西亚国际伊斯兰大学', isStart: false),
            SizedBox(height: 20),
            // sum
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text.rich(
                TextSpan(
                  text: '总额：￥',
                  style: TextStyle(color: _bodyFontColor, fontSize: 12),
                  children: [
                    TextSpan(
                      text: '850',
                      style: TextStyle(
                        color: CustomTheme.of(context).tipAlertColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
