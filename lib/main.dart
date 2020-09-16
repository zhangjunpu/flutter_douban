import 'package:flutter/material.dart';
import 'package:flutter_douban/widget/dashed_line.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: "豆瓣"),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                child: DashedLine(
                  strokeWidth: 1,
                  dashWidth: 5,
                  dashGap: 3,
                ),
              ),
              Container(
                height: 300,
                child: DashedLine(
                  axis: Axis.vertical,
                  strokeWidth: 1,
                  dashWidth: 5,
                  dashGap: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
