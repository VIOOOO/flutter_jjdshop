import 'package:flutter/material.dart';

// 我的页面
class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Text("我的页面");
  }
}