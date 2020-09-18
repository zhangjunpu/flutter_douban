import 'package:flutter/material.dart';

/// 虚线，可定义方向，需要配合[Container]使用。
/// 根据父容器尺寸计算个数，最后的留白会加到[dashGap]里，所以[dashGap]值会有误差
///
/// {@author junpu}
/// {@date 2020/9/16}
class DashedLine extends StatelessWidget {
  final Axis axis; // 方向
  final Color color; // 颜色
  final double dashWidth; // 虚线宽度
  final double dashHeight; // 虚线高度
  final double dashGap; // 虚线间隙

  const DashedLine({
    this.axis = Axis.horizontal,
    this.color = const Color(0xffcccccc),
    this.dashWidth = 1,
    this.dashHeight = 1,
    this.dashGap = 1,
  });

  @override
  Widget build(BuildContext context) {
    return buildDash();
  }

  LayoutBuilder buildDash() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double size = axis == Axis.horizontal
            ? constraints.maxWidth
            : constraints.maxHeight;
        int count = ((size + dashGap) / (dashWidth + dashGap)).floor();
        return Flex(
          direction: axis,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(count, (index) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}
