import 'package:driver/common/style/custom_theme.dart';
import 'package:driver/common/style/trip_on_icons.dart';
import 'package:driver/widgets/start_arrive_widget.dart';
import 'package:driver/widgets/to_card.dart';
import 'package:flutter/material.dart';

class OrderDetailPage extends StatefulWidget {
  OrderDetailPage(this.id);

  final int id;
  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(title: Text("订单详情")),
      body: Container(
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
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: <Widget>[
            _PriceWidget(),
            _TravelInfoWidget(),
            _PassengerInfoEditWidget(),
            additionalRequireWidget,
          ],
        ),
      ),
    );
  }

  get additionalRequireWidget => TOCard(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: IconTheme(
            data: IconThemeData(size: 18.0, color: Colors.black38),
            child: DefaultTextStyle(
              style: _additionalStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("附加要求", style: Theme.of(context).textTheme.title.copyWith(fontSize: 18)),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(TripOnIcons.brand),
                      Text("举牌接机"),
                      Text("¥ 20/一次"),
                      IconButton(
                        icon: Icon(Icons.radio_button_unchecked),
                        iconSize: 18.0,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(TripOnIcons.ertongzuoyijiekoux),
                      Text("儿童座椅"),
                      Text("¥ 20/一次"),
                      IconButton(
                        icon: Icon(Icons.radio_button_unchecked),
                        iconSize: 18.0,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  final _additionalStyle = TextStyle(
    color: Color(0xFFD5D5D5),
    fontSize: 14.0,
  );
}

class _PriceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TOCard(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          children: <Widget>[
            DefaultTextStyle(
              style: TextStyle(color: Colors.black38),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("待服务", style: Theme.of(context).textTheme.title.copyWith(fontSize: 18)),
                  RichText(
                    text: TextSpan(
                      text: "¥ ",
                      style: TextStyle(
                        color: Colors.black38,
                        fontSize: 12.0,
                      ),
                      children: [
                        TextSpan(
                          text: "850",
                          style: TextStyle(
                            color: CustomTheme.of(context).tipAlertColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            DefaultTextStyle(
              style: Theme.of(context).textTheme.caption,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("2020-03-01 08:24"),
                  Text("No.0096201548564"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TravelInfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TOCard(
      padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 36),
      child: IconTheme(
        data: IconThemeData(color: Colors.black38, size: 20.0),
        child: DefaultTextStyle(
          style: TextStyle(
            color: Color(0xFF222222),
            fontSize: 12.0,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(TripOnIcons.hangcheng),
                  SizedBox(width: 10.0),
                  Text("紧凑五座-丰田corolla等级同车"),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.check_box),
                  SizedBox(width: 10.0),
                  Expanded(child: Text("TOVOTA-丰田COASTER-15 seats")),
                ],
              ),
              SizedBox(height: 10.0),
              // start point and arrive point
              StartArriveWidget(
                title: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text('吉隆坡国际机场（吉隆坡）'),
                ),
                preferredWidth: 20,
              ),
              StartArriveWidget(
                title: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text('马来西亚国际伊斯兰大学'),
                ),
                isStart: false,
                preferredWidth: 20,
              ),
              SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  Icon(TripOnIcons.juli),
                  SizedBox(width: 10.0),
                  Expanded(child: Text("65km")),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  Icon(TripOnIcons.feiji),
                  SizedBox(width: 10.0),
                  Expanded(child: Text("D7539")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PassengerInfoEditWidget extends StatelessWidget {
  final _passengerStyle = TextStyle(
    color: Color(0xFFA2A0A0),
    fontSize: 14.0,
  );

  final _htiStyle = TextStyle(
    color: Color(0xFFAD5D5D5),
    fontSize: 14.0,
  );

  final _divider = Divider(height: 6);

  @override
  Widget build(BuildContext context) {
    return TOCard(
      padding: const EdgeInsets.only(top: 20, left: 36, right: 20, bottom: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("乘客信息", style: Theme.of(context).textTheme.title.copyWith(fontSize: 18)),
          SizedBox(height: 10.0),
          DefaultTextStyle(
            style: _passengerStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(child: Text("乘客", textAlign: TextAlign.start), flex: 1),
                    Expanded(
                      child: TextField(
                        style: _passengerStyle,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "请输入乘客姓名",
                          hintStyle: _htiStyle,
                        ),
                      ),
                      flex: 2,
                    )
                  ],
                ),
                _divider,
                Row(
                  children: <Widget>[
                    Expanded(child: Text("联系电话"), flex: 1),
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text("+86", style: TextStyle(color: Colors.black)),
                    ),
                    Expanded(
                      child: TextField(
                        style: _passengerStyle,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "请输入乘客电话",
                          hintStyle: _htiStyle,
                        ),
                      ),
                      flex: 2,
                    )
                  ],
                ),
                _divider,
                Row(
                  children: <Widget>[
                    Expanded(child: Text("邮箱"), flex: 1),
                    Expanded(
                      child: TextField(
                        style: _passengerStyle,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "请输入乘客邮箱",
                          hintStyle: _htiStyle,
                        ),
                      ),
                      flex: 2,
                    )
                  ],
                ),
                _divider,
                Row(
                  children: <Widget>[
                    Expanded(child: Text("特殊要求"), flex: 1),
                    Expanded(
                      child: TextField(
                        style: _passengerStyle,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "请输入特殊要求",
                          hintStyle: _htiStyle,
                        ),
                      ),
                      flex: 2,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
