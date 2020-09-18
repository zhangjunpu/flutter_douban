import 'package:flutter_douban/model/movie_item.dart';

import 'http_api.dart';

/// 首页请求页面
/// {@author junpu}
/// {@date 2020/9/18}
class HomeRequest {
  static int page = 1;
  static int pageSize = 20;

  /// 获取页码
  static int getPageNum(int page) {
    return page * 20 - 20;
  }

  /// 请求电影列表
  static Future<List<Movie>> requestMovieList(int page) async {
    int pageNum = getPageNum(page);
    final String url = "/v2/movie/top250";
    final result = await HttpApi.request(
      url,
      params: {"start": pageNum, "count": pageSize},
    );

    final subjects = result["subjects"];
    final List<Movie> movies = [];
    for (var item in subjects) {
      movies.add(Movie.fromJsonMap(item));
    }
    return movies;
  }
}
