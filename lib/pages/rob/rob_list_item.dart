import 'package:driver/common/api/order/order.dart';
import 'package:driver/common/model/common.dart';
import 'package:driver/common/model/order/order_detail.dart';
import 'package:driver/common/utils/common_util.dart';
import 'package:driver/common/utils/order.dart';
import 'package:driver/shared_state/user_info.dart';
import 'package:driver/widgets/small_circle_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RobListItem extends StatelessWidget {
  RobListItem(this.info, {this.success, this.failed, this.onTap});

  final OrderInfoModel info;
  final VoidCallback onTap;
  final VoidCallback success;
  final VoidCallback failed;

  @override
  Widget build(BuildContext context) {
    final actionBuilder = (context) {
      return _RobBtn(info, success: success, failed: failed);
    };

    final child = OrderUtil.mapListItemByType(
      info,
      actionBuilder: actionBuilder,
    );
    return GestureDetector(
      onTap: onTap ?? () {},
      child: child ?? Container(),
    );
  }
}

class _RobBtn extends StatefulWidget {
  _RobBtn(this.info, {this.success, this.failed});

  final OrderInfoModel info;
  final VoidCallback success;
  final VoidCallback failed;

  @override
  __RobBtnState createState() => __RobBtnState();
}

class __RobBtnState extends State<_RobBtn> {
  var _isLoading = false;

  Future<void> _grab(String orderId, String driverId) async {
    CommonUtils.showMessage('Taking...');

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
      CommonUtils.showMessage('Take Success!');
      if (widget.success != null) {
        widget.success();
      }
    } else {
      CommonUtils.showMessage('Take Failed!');
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
          BoxShadow(
            color: Color(0xFF4FAFF8),
            offset: Offset(0, 2),
            blurRadius: 4.0,
          )
        ],
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: FlatButton(
        textColor: Colors.white,
        child: _isLoading
            ? SmallCircleIndicator(color: Colors.white)
            : Text(
                'Take',
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
