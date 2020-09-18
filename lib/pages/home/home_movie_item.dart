import 'package:flutter/material.dart';
import 'package:flutter_douban/model/movie_item.dart';
import 'package:flutter_douban/widget/dashed_line.dart';
import 'package:flutter_douban/widget/rating_start.dart';

class HomeMovieItem extends StatelessWidget {
  final Movie movie;

  HomeMovieItem(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildContent(),
          buildFooter(),
        ],
      ),
    );
  }

  /// 1. 构建基础信息
  Widget buildContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 8),
        buildImage(),
        SizedBox(width: 8),
        Expanded(child: buildInfo()),
        SizedBox(width: 8),
        buildDashedLine(),
        SizedBox(width: 8),
        buildWish(),
      ],
    );
  }

  /// 1.1 构建影片图片
  Widget buildImage() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          child: FadeInImage.assetNetwork(
            placeholder: "assets/images/ic_default_h.png",
            imageErrorBuilder: (context, err, stackTrace) {
              print('$err, $stackTrace');
              return Image.asset("assets/images/ic_default_h.png",
                  width: 108, height: 160);
            },
            image: movie.images.large,
            width: 108,
            height: 160,
          ),
        ),
        buildRank(),
      ],
    );
  }

  /// 1.1.1 构建排名
  Widget buildRank() {
    Color color;
    if (movie.rank == 1) {
      color = Colors.amber;
    } else if (movie.rank == 2) {
      color = Colors.white;
    } else if (movie.rank == 3) {
      color = Colors.orange;
    } else {
      color = Colors.black45;
    }
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(Icons.bookmark, color: color, size: 30),
        Container(
            padding: EdgeInsets.only(bottom: 3),
            child: Text("${movie.rank}",
                style: TextStyle(fontSize: 14, color: Colors.white)))
      ],
    );
  }

  /// 1.2 构建信息主体
  Widget buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildInfoTitle(),
        SizedBox(width: 36),
        buildInfoRating(),
        SizedBox(width: 36),
        buildInfoMessage(),
      ],
    );
  }

  /// 1.2.1 构建信息标题
  Widget buildInfoTitle() {
    return Text.rich(TextSpan(children: [
      WidgetSpan(
        child: Icon(Icons.play_circle_outline, color: Colors.pink, size: 24),
      ),
      WidgetSpan(child: SizedBox(width: 5)),
      TextSpan(
        text: movie.title.split(" ")[0],
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      )
    ]));
  }

  /// 1.2.2 构建评分
  Widget buildInfoRating() {
    return Row(
      children: [
        RatingStart(
          rating: movie.rating.average,
          size: 16,
          selectedColor: Colors.orange,
        ),
        SizedBox(width: 5),
        Text("${movie.rating.average}",
            style: TextStyle(fontSize: 16, color: Colors.orange)),
      ],
    );
  }

  /// 1.2.3 构建信息消息
  Widget buildInfoMessage() {
    var countries = movie.countries.join(" ");
    var genres = movie.genres.join(" ");
    var directors = movie.directors.map((e) => e.name).join(" ");
    var actors = movie.casts.map((e) => e.name).join(" ");
    return Text("${movie.year} / $countries / $genres / $directors / $actors");
  }

  /// 1.3 构建虚线
  Widget buildDashedLine() {
    return Container(
      height: 100,
      child: DashedLine(
        axis: Axis.vertical,
        dashWidth: 1,
        dashHeight: 3,
        dashGap: 3,
      ),
    );
  }

  /// 1.4 构建想看
  Widget buildWish() {
    return Container(
      padding: EdgeInsets.all(12),
      height: 100,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/images/home/wish.png", width: 35),
            Text("想看", style: TextStyle(fontSize: 20, color: Colors.orange)),
          ],
        ),
      ),
    );
  }

  /// 2. 构建尾部信息
  Widget buildFooter() {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xfff2f2f2),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Text(movie.original_title),
    );
  }
}
