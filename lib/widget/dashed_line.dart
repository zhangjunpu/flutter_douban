import 'package:flutter/material.dart';

/// 虚线，可定义方向，需要配合[Container]使用。
/// 根据父容器尺寸计算个数，最后的留白会加到[dashGap]里，所以[dashGap]值会有误差
///
/// {@author junpu}
/// {@date 2020/9/16}
class DashedLine extends StatefulWidget {
  final Axis axis; // 方向
  final Color color; // 颜色
  final double dashWidth; // 虚线宽度
  final double dashHeight; // 虚线高度
  final double dashGap; // 虚线间隙

  DashedLine(
      {this.axis = Axis.horizontal,
      this.color = const Color(0xffcccccc),
      this.dashWidth = 1,
      this.dashHeight = 1,
      this.dashGap = 1});

  @override
  _DashedLineState createState() => _DashedLineState();
}

class _DashedLineState extends State<DashedLine> {
  double length = 100;

  /// 是否是横着的
  bool _isHorizontal() => widget.axis == Axis.horizontal;

  @override
  void initState() {
    super.initState();
    // 监听widget渲染完成
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        length = _isHorizontal() ? context.size.width : context.size.height;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = _isHorizontal() ? widget.dashWidth : widget.dashHeight;
    double gap = widget.dashGap;
    int count = ((length + gap) / (width + gap)).floor();
    return Flex(
      direction: widget.axis,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(count, (index) {
        return SizedBox(
          width: widget.dashWidth,
          height: widget.dashHeight,
          child: DecoratedBox(
            decoration: BoxDecoration(color: widget.color),
          ),
        );
      }),
    );
  }
}
