import 'package:flutter/material.dart';

/// 评分Widget
/// [author] junpu
/// [date] 2020/9/15
class RatingStart extends StatefulWidget {
  final double rating; // 当前分数
  final double maxRating; // 最大分数
  final int count; // 星星数量
  final double size; // 星星大小
  final Color unselectedColor; // 未选中颜色
  final Color selectedColor; // 选中颜色

  final Widget unselectedImage; // 未选中星星
  final Widget selectedImage; // 选中星星

  RatingStart({
    Key key,
    @required this.rating,
    this.maxRating = 10,
    this.count = 5,
    this.size = 30,
    this.unselectedColor = const Color(0xffbbbbbb),
    this.selectedColor = const Color(0xffff0000),
    Widget unselectedImage,
    Widget selectedImage,
  })  : unselectedImage = unselectedImage ??
            Icon(Icons.star_border, color: unselectedColor, size: size),
        selectedImage =
            selectedImage ?? Icon(Icons.star, color: selectedColor, size: size),
        super(key: key);

  @override
  _RatingStartState createState() => _RatingStartState();
}

class _RatingStartState extends State<RatingStart> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(mainAxisSize: MainAxisSize.min, children: buildUnselectedStars()),
        Row(mainAxisSize: MainAxisSize.min, children: buildSelectedStars()),
      ],
    );
  }

  List<Widget> buildUnselectedStars() {
    return List.generate(widget.count, (index) {
      return widget.unselectedImage;
    });
  }

  List<Widget> buildSelectedStars() {
    List<Widget> list = [];
    // 1. 初始化star
    final star = widget.selectedImage;

    // 2. 添加完整的star
    double oneValue = widget.maxRating / widget.count;
    int entireCount = (widget.rating / oneValue).floor();
    for (var i = 0; i < entireCount; i++) {
      list.add(star);
    }

    // 3. 添加不完整的star
    double clipperScore = (widget.rating / oneValue) - entireCount;
    double clipperWidth = clipperScore * widget.size;
    list.add(ClipRect(
      clipper: StarClipper(clipperWidth),
      child: star,
    ));

    if (list.length > widget.count) {
      list = list.sublist(0, widget.count);
    }
    return list;
  }
}

/// 不完整的star
/// [author] junpu
/// [date] 2020/9/15
class StarClipper extends CustomClipper<Rect> {
  double width;

  StarClipper(this.width);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, width, size.height);
  }

  @override
  bool shouldReclip(StarClipper oldClipper) {
    return oldClipper.width != width;
  }
}
