import 'package:driver/common/api/order/order.dart';
import 'package:driver/common/model/order/rob_list_res.dart';
import 'package:loading_more_list/loading_more_list.dart' show LoadingMoreBase;

class RobListRepo extends LoadingMoreBase<RobInfo> {
  bool _hasMore = true;
  int _start = 0;
  int _count = 20;

  String driverId;

  @override
  bool get hasMore => _hasMore;

  @override
  Future<bool> loadData([bool isLoadMoreAction = false]) async {
    bool successful = true;

    try {
      RobListRes res = await OrderApi.getRobList(
        driverId,
        start: _start,
        count: _count
      );

      if (_hasMore) {
        _start += 20;
        this.addAll(res.data.info ?? []);
        _hasMore = _count <= (res?.data?.info?.length ?? 0);
      }
    } catch (e) {
      successful = false;
    }

    return Future.value(successful);
  }

  @override
  Future<bool> refresh([bool notifyStateChanged = false]) async {
    _start = 0;
    _hasMore = true;
    return super.refresh(true);
  }
}
