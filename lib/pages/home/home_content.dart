import 'package:flutter/material.dart';
import 'package:flutter_douban/http/home_request.dart';
import 'package:flutter_douban/model/movie_item.dart';
import 'package:flutter_douban/pages/home/home_movie_item.dart';

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  int page = 1;
  List<Movie> movies = [];

  @override
  void initState() {
    super.initState();
    HomeRequest.requestMovieList(page).then((value) {
      setState(() {
        movies = value;
      });
    }).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return HomeMovieItem(movies[index]);
      },
      itemCount: movies.length,
    );
  }
}
