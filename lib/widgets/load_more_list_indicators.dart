import 'package:flutter/material.dart';
import 'data_indicators.dart';
import 'package:loading_more_list/loading_more_list.dart';

class ListStatus {
  final BuildContext context;
  final LoadingMoreBase repo;
  final bool isSliver;

  const ListStatus({this.context, this.repo, this.isSliver = false})
      : assert(context != null && repo != null && isSliver != null);

  Widget indicatorBuilder(BuildContext context, IndicatorStatus status) {
    Widget widget = Container();
    switch (status) {
      case IndicatorStatus.none:
        widget = Container();
        break;
      case IndicatorStatus.loadingMoreBusying:
        widget = LoadingWidget(isSliver: false);
        break;
      case IndicatorStatus.fullScreenBusying:
        widget = LoadingWidget(isFullPage: true, isSliver: isSliver);
        break;
      case IndicatorStatus.error:
        widget = LoadErrorWidget(isSliver: false, refreshFn: repo.refresh);
        break;
      case IndicatorStatus.fullScreenError:
        widget = LoadErrorWidget(isSliver: isSliver, isFullPage: true, refreshFn: repo.refresh);
        break;
      case IndicatorStatus.noMoreLoad:
        widget = Container();
        break;
      case IndicatorStatus.empty:
        widget = NoDataWidget(isSliver: isSliver, isFullPage: true);
        break;
      default:
        widget = Container();
    }
    return widget;
  }
}
