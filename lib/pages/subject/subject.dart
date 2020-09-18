import 'package:flutter/material.dart';

import 'subject_content.dart';

class SubjectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("书影音"),
      ),
      body: SubjectContent(),
    );
  }
}
