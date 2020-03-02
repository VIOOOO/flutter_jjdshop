import 'package:flutter/material.dart';

// 引入状态管理库 和自己创建的状态文件
import 'package:provider/provider.dart';
import '../../provider/Counter.dart';

// 我的页面
class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    // 获取状态管理内的状态类
    // var counterProvider = Provider.of<Counter>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("用户中心"),
      ),
      body: Center(
        child: Text("用户中心"),
      ),
    );
  }
}
