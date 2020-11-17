import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:driver/common/api/order/order.dart';
import 'package:driver/common/enums/order.dart';
import 'package:driver/common/model/order/order_detail.dart';
import 'package:driver/common/style/custom_theme.dart';
import 'package:driver/common/utils/common_util.dart';
import 'package:driver/common/utils/log.dart';
import 'package:driver/common/utils/order.dart';
import 'package:driver/widgets/main_container.dart';
import 'package:driver/widgets/small_circle_indicator.dart';
import 'package:driver/widgets/to_card.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// 订单详情
class OrderDetailPage extends StatefulWidget {
  OrderDetailPage(this.order);

  final OrderInfoModel order;

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  OrderInfoModel _order;
  var _isPageLoading = false;
  var _isCancelLoading = false;
  var _isConfirmLoading = false;

  @override
  void initState() {
    super.initState();
    _order = widget.order;
  }

  void _cancelTap() {
    showOkCancelAlertDialog(
      context: context,
      message: 'Do you want to cancel this order ?',
      okLabel: 'confirm',
      cancelLabel: 'cancel',
      isDestructiveAction: true,
    ).then((value) {
      if (value == OkCancelResult.ok) {
        _cancelOrder();
      }
    });
  }

  Future<void> _cancelOrder() async {
    setState(() {
      _isCancelLoading = true;
    });
    var hasErr = false;

    try {
      final res = await OrderApi.changeOrderStatus(
        orderId: _order.id,
        state: OrderOperationState.cancel,
      );
      hasErr = res.code == 0;
    } catch (e) {
      hasErr = true;
      LogUtil.v(e);
    }

    if (hasErr) {
      CommonUtils.showMessage('Some thing error');
    } else {
      CommonUtils.showMessage('Canceled');
    }
    setState(() {
      _isCancelLoading = false;
    });
    _getOrderDetail(_order.id);
  }

  Future<void> _updateState(int state) async {
    setState(() {
      _isConfirmLoading = true;
    });
    var hasErr = false;

    try {
      final res = await OrderApi.changeOrderStatus(
        orderId: _order.id,
        state: state,
      );
      hasErr = res.code == 0;
    } catch (e) {
      hasErr = true;
      LogUtil.v(e);
    }

    if (hasErr) {
      CommonUtils.showMessage('Some thing error');
    } else {
      CommonUtils.showMessage('Success');
    }
    setState(() {
      _isConfirmLoading = false;
    });
    _getOrderDetail(_order.id);
  }

  Future<void> _getOrderDetail(int id) async {
    setState(() {
      _isPageLoading = true;
    });
    try {
      final res = await OrderApi.getOrderDetail(id);
      setState(() {
        _order = res.data;
      });
    } catch (e) {
      CommonUtils.showMessage('reload order failed');
    }
    setState(() {
      _isPageLoading = false;
    });
  }

  Widget _operationWidget(OrderInfoModel order) {
    List<Widget> operations;
    if (_order.state == OrderState.picked) {
      operations = [
        Expanded(
          child: OutlineButton(
            borderSide: BorderSide(
              color: Colors.red,
              width: .6,
            ),
            child: _isCancelLoading
                ? SmallCircleIndicator(
                    color: Colors.red,
                    drawWidth: 3,
                  )
                : Text(
                    'cancel',
                    style: TextStyle(color: Colors.red),
                  ),
            onPressed: _cancelTap,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: FlatButton(
            color: Theme.of(context).primaryColor,
            child: _isConfirmLoading
                ? SmallCircleIndicator()
                : Text(
                    'confirm',
                    style: TextStyle(color: Colors.white),
                  ),
            onPressed: () {
              if (_isConfirmLoading) return;
              _updateState(OrderOperationState.confirmPassenger);
            },
          ),
        )
      ];
    } else if (_order.state == OrderState.passengerOnBoard) {
      operations = [
        Expanded(
          child: FlatButton(
            color: Theme.of(context).primaryColor,
            child: _isConfirmLoading
                ? SmallCircleIndicator()
                : Text(
                    'complete',
                    style: TextStyle(color: Colors.white),
                  ),
            onPressed: () async {
              if (_isConfirmLoading) return;
              _updateState(OrderOperationState.complete);
            },
          ),
        ),
      ];
    }
    return operations == null
        ? null
        : SafeArea(
            child: Container(
              height: 60,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
              ),
              child: Row(children: operations),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Order Detail")),
      body: MainContainer(
        child: _isPageLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: <Widget>[
                  _PriceWidget(widget.order),
                  OrderUtil.mapTravelWidgetByType(widget.order) ?? Container(),
                  _PassengerInfoDisplayWidget(widget.order),
                  if (widget.order.serviceInfo != null)
                    _AdditionalWidget(widget.order.serviceInfo),
                ],
              ),
      ),
      bottomNavigationBar: _isPageLoading ? null : _operationWidget(_order),
    );
  }
}

class _PriceWidget extends StatelessWidget {
  _PriceWidget(this.order);

  final OrderInfoModel order;

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
                  Text(
                    OrderUtil.mapOrderStatus(order.state),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(fontSize: 18),
                  ),
                  if (order.payTotalMoney != null)
                    RichText(
                      text: TextSpan(
                        text: "RM ",
                        style: TextStyle(color: Colors.black38, fontSize: 12.0),
                        children: [
                          TextSpan(
                            text: '${order.payTotalMoney ?? ''}',
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
                  Text(order.createTime ?? ''),
                  Text('No.${order.outTradeNo}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PassengerInfoDisplayWidget extends StatelessWidget with _FormLineMixin {
  _PassengerInfoDisplayWidget(this.order);

  final OrderInfoModel order;

  @override
  Widget build(BuildContext context) {
    return TOCard(
      padding: const EdgeInsets.only(top: 20, left: 36, right: 20, bottom: 26),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Passenger information",
            style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18),
          ),
          SizedBox(height: 16),
          Column(
            children: <Widget>[
              _buildFormLine('passenger', order.rideName ?? '--'),
              _divider,
              if (order.rideTel != null && order.rideTel != '')
                GestureDetector(
                  onTap: () {
                    CommonUtils.callPhone(context, order.rideTel);
                  },
                  child: _buildFormLine(
                    'phone',
                    order.rideTel,
                    rightStyle: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blue,
                    ),
                  ),
                )
              else
                _buildFormLine('phone', '--'),
              _divider,
              _buildFormLine('requirements', order.remark ?? '--'),
            ],
          ),
        ],
      ),
    );
  }
}

class _AdditionalWidget extends StatelessWidget with _FormLineMixin {
  _AdditionalWidget(this.info);

  final List<ServiceInfo> info;

  @override
  Widget build(BuildContext context) {
    return TOCard(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: IconTheme(
          data: IconThemeData(size: 18.0, color: Colors.black38),
          child: DefaultTextStyle(
            style: TextStyle(
              color: Color(0xFFD5D5D5),
              fontSize: 14.0,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Additional services",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .copyWith(fontSize: 18),
                ),
                for (var i in info) ...[
                  SizedBox(height: 10.0),
                  _buildFormLine(i.serviceName, 'RM${i.serviceMoney}')
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FormLineMixin {
  final _divider = Divider(height: 16);

  final _passengerStyle = TextStyle(
    color: Color(0xFFA2A0A0),
    fontSize: 14.0,
  );

  Widget _buildFormLine(
    String left,
    String right, {
    TextStyle leftStyle,
    TextStyle rightStyle,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Text(left, style: leftStyle ?? _passengerStyle),
          flex: 1,
        ),
        Expanded(
          child: Text(right, style: rightStyle, textAlign: TextAlign.end),
          flex: 2,
        )
      ],
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
          Text(
            "乘客信息",
            style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18),
          ),
          SizedBox(height: 10.0),
          DefaultTextStyle(
            style: _passengerStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Text("乘客", textAlign: TextAlign.start), flex: 1),
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
