import 'package:flutter/material.dart';
import 'package:flutter_douban/http/home_request.dart';
import 'package:flutter_douban/model/movie_item.dart';
import 'package:flutter_douban/pages/home/home_movie_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  int page = 1;
  List<Movie> movies = [];
  RefreshController _refreshController = RefreshController();

  /// 是否为最后一页
  bool _isLasePage() => movies.length >= 250;

  /// 下拉刷新
  void _onRefresh() {
    page = 1;
    movieRankIndex = 0;
    _refreshController.resetNoData();
    HomeRequest.requestMovieList(page).then((value) {
      setState(() {
        movies = value;
      });
      _refreshController.refreshCompleted();
      if (!_isLasePage()) {
        page++;
      }
    }).catchError((err) {
      print(err);
      _refreshController.refreshFailed();
    });
  }

  /// 加载更多
  void _onLoadMore() {
    HomeRequest.requestMovieList(page).then((value) {
      setState(() {
        movies.addAll(value);
      });
      _refreshController.loadComplete();
      if (!_isLasePage()) {
        page++;
      } else {
        _refreshController.loadNoData();
      }
    }).catchError((err) {
      print(err);
      _refreshController.loadFailed();
    });
  }

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: _buildHeader(),
      footer: _buildFooter(),
      // footer: _buildCustomFooter(),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoadMore,
      child: ListView.builder(
        itemBuilder: (context, index) => HomeMovieItem(movies[index]),
        itemCount: movies.length,
      ),
    );
  }

  /// 构建下拉刷新View
  ClassicHeader _buildHeader() {
    return ClassicHeader(
      idleText: "下拉刷新",
      releaseText: "释放刷新",
      refreshingText: "正在刷新",
      completeText: "刷新完成",
      failedText: "刷新失败",
    );
  }

  /// 构建加载更多View
  ClassicFooter _buildFooter() {
    return ClassicFooter(
      idleText: "上拉加载",
      canLoadingText: "释放加载",
      loadingText: "正在加载",
      noDataText: "没有更多数据了",
      failedText: "加载失败，点击重试！",
    );
  }

  /// 自定义Footer
  CustomFooter _buildCustomFooter() {
    return CustomFooter(
      builder: (context, mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = Text("上拉加载");
        } else if (mode == LoadStatus.loading) {
          // body = CupertinoActivityIndicator();
          body = Container(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          );
        } else if (mode == LoadStatus.failed) {
          body = Text("加载失败！点击重试！");
        } else if (mode == LoadStatus.canLoading) {
          body = Text("松手,加载更多!");
        } else {
          body = Text("没有更多数据了!");
        }
        return Container(
          height: 60,
          child: Center(child: body),
        );
      },
    );
  }
}
