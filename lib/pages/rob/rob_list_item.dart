import 'package:driver/common/api/order/order.dart';
import 'package:driver/common/model/common.dart';
import 'package:driver/common/model/order/rob_list_res.dart';
import 'package:driver/common/style/custom_theme.dart';
import 'package:driver/common/style/trip_on_icons.dart';
import 'package:driver/common/utils/common_util.dart';
import 'package:driver/shared_state/user_info.dart';
import 'package:driver/widgets/small_circle_indicator.dart';
import 'package:driver/widgets/start_arrive_widget.dart';
import 'package:driver/widgets/to_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RobListItem extends StatelessWidget {
  RobListItem(this.info, {this.success, this.failed, this.onTap});

  final RobInfo info;
  final VoidCallback onTap;
  final VoidCallback success;
  final VoidCallback failed;

  final _bodyFontColor = Color(0xFFA2A0A0);

  @override
  Widget build(BuildContext context) {
    final transformType = 'Ride-hailing';
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
                Text(
                  transformType,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .copyWith(fontSize: 18),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      const SizedBox(height: 10),
                      Text(
                        info.createTime ?? '',
                        style: TextStyle(color: _bodyFontColor, fontSize: 12),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'No.${info.outTradeNo ?? ''}',
                        style: TextStyle(color: _bodyFontColor, fontSize: 10),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    top: 6,
                    bottom: 6,
                    right: 10,
                  ),
                  child: Icon(
                    TripOnIcons.shijian,
                    color: _bodyFontColor,
                    size: 20,
                  ),
                ),
                Text(
                  info.other.startTime,
                  style: TextStyle(color: _bodyFontColor, fontSize: 12),
                ),
              ],
            ),
            // start point and arrive point
            StartArriveWidget(title: Text(info.other.startAddress)),
            StartArriveWidget(
              title: Text(info.other.endAddress),
              isStart: false,
            ),
            SizedBox(height: 20),
            // sum
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text.rich(
                    TextSpan(
                      text: 'lump sum：￥',
                      style: TextStyle(color: _bodyFontColor, fontSize: 12),
                      children: [
                        TextSpan(
                          text: '${info.payTotalMoney?.toString() ?? ''}',
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
                _RobBtn(info, success: success, failed: failed),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RobBtn extends StatefulWidget {
  _RobBtn(this.info, {this.success, this.failed});

  final RobInfo info;
  final VoidCallback success;
  final VoidCallback failed;

  @override
  __RobBtnState createState() => __RobBtnState();
}

class __RobBtnState extends State<_RobBtn> {
  var _isLoading = false;

  Future<void> _grab(String orderId, String driverId) async {
    CommonUtils.showMessage('Grabbing...');

    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });
    StringRes res;
    var hasError = false;
    try {
      res = await OrderApi.robOrder(
        orderId: orderId,
        driverId: driverId,
      );
      hasError = res.code == 0;
    } catch (e) {
      hasError = true;
    }

    setState(() {
      _isLoading = false;
    });

    if (!hasError) {
      CommonUtils.showMessage('Grab Success!');
      if (widget.success != null) {
        widget.success();
      }
    } else {
      CommonUtils.showMessage('Grab Failed!');
      if (widget.failed != null) {
        widget.failed();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: Color(0xFF2096F3),
          boxShadow: [
            //阴影
            BoxShadow(
                color: Color(0xFF4FAFF8), offset: Offset(0, 2), blurRadius: 4.0)
          ],
          borderRadius: BorderRadius.circular(30.0)),
      child: FlatButton(
        textColor: Colors.white,
        child: _isLoading
            ? SmallCircleIndicator(color: Colors.white)
            : Text(
                'Grab',
                style: TextStyle(fontSize: 18),
              ),
        onPressed: () {
          final userInfoProvider =
              Provider.of<UserInfoProvider>(context, listen: false);
          _grab(widget.info.id.toString(),
              userInfoProvider.userInfo.id.toString());
        },
      ),
    );
  }
}
