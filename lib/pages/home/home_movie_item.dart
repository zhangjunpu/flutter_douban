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
        Expanded(
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: buildInfo()),
                SizedBox(width: 8),
                buildDashedLine(),
                SizedBox(width: 8),
                buildWish(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// 1.1 构建影片图片
  Widget buildImage() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: FadeInImage.assetNetwork(
            placeholder: "assets/images/ic_default_h.png",
            imageErrorBuilder: (context, err, stackTrace) {
              print('$err, $stackTrace');
              return Container(
                width: 108,
                height: 160,
                color: Color(0xffeeeeee),
                child: Icon(Icons.photo, color: Color(0xffbbbbbb), size: 40),
              );
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
    Color bgColor;
    Color textColor;
    if (movie.rank == 1) {
      bgColor = Color(0xffFFD700);
    } else if (movie.rank == 2) {
      bgColor = Color(0xffe6e8fa);
    } else if (movie.rank == 3) {
      bgColor = Color(0xffb87333);
    } else {
      bgColor = Colors.black54;
    }
    if (movie.rank == 2) {
      textColor = Color(0xff222222);
    } else {
      textColor = Colors.white;
    }
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(Icons.bookmark, color: bgColor, size: 30),
        Container(
            padding: EdgeInsets.only(bottom: 3),
            child: Text("${movie.rank}",
                style: TextStyle(fontSize: 14, color: textColor)))
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
    return Text.rich(
      TextSpan(children: [
        WidgetSpan(
          child: Icon(Icons.play_circle_outline, color: Colors.pink, size: 28),
          alignment: PlaceholderAlignment.middle,
        ),
        WidgetSpan(child: SizedBox(width: 5)),
        ...movie.title.split(" ")[0].runes.map((e) {
          return WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Text(
              String.fromCharCode(e),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          );
        }).toList(),
      ]),
    );
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

  /// 1.2.3 构建信息内容
  Widget buildInfoMessage() {
    var countries = movie.countries.join(" ");
    var genres = movie.genres.join(" ");
    var directors = movie.directors.map((e) => e.name).join(" ");
    var actors = movie.casts
        .map((e) => e.name)
        .skipWhile((value) => value == movie.directors[0].name)
        .join(" ");
    return Text(
      "${movie.year} / $countries / $genres / $directors / $actors",
      style: TextStyle(color: Color(0xff999999)),
    );
  }

  /// 1.3 构建虚线
  Widget buildDashedLine() {
    return Container(
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
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(movie.original_title),
    );
  }
}
