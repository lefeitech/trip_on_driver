import 'package:driver/common/model/user/user_info.dart';
import 'package:driver/common/style/custom_theme.dart';
import 'package:driver/widgets/rating_bar.dart';
import 'package:driver/common/style/trip_on_icons.dart';
import 'package:driver/pages/mine/my_info_card.dart';
import 'package:driver/pages/setting/setting.dart';
import 'package:driver/shared_state/user_info.dart';
import 'package:driver/widgets/data_indicators.dart';
import 'package:driver/widgets/gradient_icon.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui show PlaceholderAlignment;

import 'package:provider/provider.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  final double _introCardHeight = 74;

  final _introCardPadding = EdgeInsets.only(left: 16, bottom: 46, right: 16);

  final double _bottomHeight = 80;

  double _titleOpt = 0;

  @override
  Widget build(BuildContext context) {
    final safePadding = MediaQuery.of(context).padding.top;
    final paddingTop = safePadding + kToolbarHeight;
    final double contentHeight =
        _introCardHeight + _introCardPadding.top + _introCardPadding.bottom;

    return Scaffold(
      body: Consumer<UserInfoProvider>(
        builder: (_, UserInfoProvider infoProvider, __) => NotificationListener(
          onNotification: (ScrollNotification value) {
            final offset = value.metrics.pixels;
            final opt =
                1 - ((contentHeight - offset) / kToolbarHeight).clamp(0.0, 1.0);
            if (contentHeight - offset < kToolbarHeight && _titleOpt != opt) {
              setState(() {
                _titleOpt = opt;
              });
            }
            return false;
          },
          child: infoProvider.userInfo != null
              ? CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      expandedHeight: contentHeight -
                          safePadding +
                          paddingTop +
                          _bottomHeight +
                          kToolbarHeight,
                      title: Opacity(
                        opacity: _titleOpt,
                        child: Text(infoProvider.userInfo.driverName),
                      ),
                      actions: <Widget>[
                        IconButton(
                          icon: Icon(TripOnIcons.shezhi),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SettingPage(),
                              ),
                            );
                          },
                        ),
                        // IconButton(
                        //   icon: Icon(TripOnIcons.xiaoxi1),
                        //   onPressed: () {},
                        // )
                      ],
                      flexibleSpace: FlexibleSpaceBar(
                        background: Container(
                          margin: EdgeInsets.only(top: paddingTop),
                          padding: _introCardPadding,
                          alignment: Alignment.topCenter,
                          child: UserInfoCard(
                            infoProvider.userInfo,
                            height: _introCardHeight,
                          ),
                        ),
                      ),
                      bottom: _BottomInfo(_bottomHeight, infoProvider.userInfo),
                    ),
                    SliverToBoxAdapter(child: MineInfoCard()),
                  ],
                )
              : LoadingWidget(isFullPage: true),
        ),
      ),
    );
  }
}

class UserInfoCard extends StatelessWidget {
  UserInfoCard(this.info, {this.height});

  final UserInfoModel info;
  final double height;

  @override
  Widget build(BuildContext context) {
    final stars = List.filled(
      5,
      WidgetSpan(
        child: GradientIcon(
          icon: TripOnIcons.xingxing,
          iconSize: 18,
          gradient: RadialGradient(
            colors: [Color(0xFFEFE38F), Color(0xFFDFB152)],
          ),
        ),
      ),
    );
    return Container(
      height: height,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: height,
            height: height,
            child: CircleAvatar(
              backgroundColor: Colors.black12,
              child: Text(
                info.driverName.substring(0, 1).toUpperCase(),
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                info.driverName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              // todo check this
              Text.rich(
                TextSpan(
                  text: 'Service index: ',
                  children: [
                    WidgetSpan(
                      child: RatingBar(
                        rating: info.score ?? 0,
                        size: 20,
                        color: Color(0xFFF6DE9B),
                        icon: Icon(
                          TripOnIcons.xingxing,
                          size: 18,
                          color: Colors.grey[400],
                        ),
                        isIndicator: true,
                        allowHalfRating: true,
                      ),
                    ),
                  ],
                ),
                style: TextStyle(color: Colors.white.withOpacity(.8)),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _BottomInfo extends StatelessWidget implements PreferredSizeWidget {
  final double _bottomHeight;
  final UserInfoModel info;

  _BottomInfo(this._bottomHeight, this.info);

  final _iconSize = 26.0;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + _bottomHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(kToolbarHeight / 2),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: kToolbarHeight / 2),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text.rich(TextSpan(
                text: '',
                children: [
                  WidgetSpan(
                    child: GradientIcon(
                      icon: TripOnIcons.zichan,
                      gradient: RadialGradient(
                        colors: [
                          Color(0xFFF6DE9B),
                          Color(0xFFEAB951),
                        ],
                      ),
                    ),
                    alignment: ui.PlaceholderAlignment.middle,
                  ),
                  TextSpan(text: ' Total assets：'),
                  TextSpan(
                    text: (info.totalMoney ?? 0).toString(),
                    style: TextStyle(
                      color: CustomTheme.of(context).tipAlertColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )),
              // delete this when blow code enable
              SizedBox(height: 50),
              // FlatButton(
              //   child: Text.rich(
              //     TextSpan(
              //       text: 'Detail  ',
              //       style: Theme.of(context).textTheme.caption,
              //       children: [
              //         WidgetSpan(
              //           child: Icon(Icons.arrow_forward_ios,
              //               size: 20, color: Colors.black12),
              //           alignment: ui.PlaceholderAlignment.middle,
              //         ),
              //       ],
              //     ),
              //   ),
              //   onPressed: () {
              //     // todo detail
              //   },
              // )
            ],
          ),
          Divider(height: 1),
          Container(
            height: _bottomHeight,
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _ColumnIconLabel(
                  icon: GradientIcon(
                    iconSize: _iconSize,
                    icon: TripOnIcons.haoping,
                    gradient: RadialGradient(
                      colors: [
                        Color(0xFFF9714b),
                        Color(0xFFFB7D5A),
                      ],
                    ),
                  ),
                  text: '好评',
                  count: 99,
                ),
                _ColumnIconLabel(
                  icon: GradientIcon(
                    iconSize: _iconSize,
                    icon: TripOnIcons.zhongping,
                    gradient: RadialGradient(
                      colors: [
                        Color(0xFF0DB7FF),
                        Color(0xFF5CC9FF),
                      ],
                    ),
                  ),
                  text: '好评',
                  count: 99,
                ),
                _ColumnIconLabel(
                  icon: GradientIcon(
                    iconSize: _iconSize,
                    icon: TripOnIcons.bad,
                    gradient: RadialGradient(
                      colors: [
                        Color(0xFF716F72),
                        Color(0xFF9B9A9D),
                      ],
                    ),
                  ),
                  text: '好评',
                  count: 99,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ColumnIconLabel extends StatelessWidget {
  _ColumnIconLabel(
      {this.icon,
      this.text = '',
      this.count = 0,
      this.textStyle,
      this.countStyle});

  final Widget icon;
  final String text;
  final int count;
  final TextStyle textStyle;
  final TextStyle countStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: icon),
        Text.rich(
          TextSpan(
            text: '$text ',
            style: textStyle,
            children: [
              TextSpan(
                text: count > 99 ? '99+' : count.toString(),
                style: countStyle ??
                    TextStyle(color: CustomTheme.of(context).tipAlertColor),
              )
            ],
          ),
          style: TextStyle(fontSize: 13),
        ),
      ],
    );
  }
}
