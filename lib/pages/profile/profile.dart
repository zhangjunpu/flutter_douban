import 'package:flutter/material.dart';

import 'profile_content.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("个人"),
      ),
      body: ProfileContent(),
    );
  }
}
