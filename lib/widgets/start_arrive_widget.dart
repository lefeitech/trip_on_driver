import 'package:driver/widgets/timeline_node.dart';
import 'package:flutter/material.dart';

class StartArriveWidget extends StatelessWidget {
  StartArriveWidget({@required this.title, this.isStart = true, this.preferredWidth = 50});

  final Widget title;
  final double preferredWidth;

  final bool isStart;

  @override
  Widget build(BuildContext context) {
    final _padding = const EdgeInsets.symmetric(vertical: 6);
    return TimelineNode(
      style: TimelineNodeStyle(
        type: TimelineNodeType.Left,
        lineType: isStart ? TimelineNodeLineType.BottomHalf : TimelineNodeLineType.TopHalf,
        pointType: TimelineNodePointType.Circle,
        pointColor: Color(0xFFE5E5E5),
        pointRadius: 4,
        lineWidth: .33,
        preferredWidth: preferredWidth,
      ),
      child: Padding(padding: _padding, child: title),
    );
  }
}
