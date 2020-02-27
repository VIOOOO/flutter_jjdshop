import 'package:flutter/material.dart';
import '../services/ScreenAdapter.dart';

// 搜索页面
class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: TextField(
            // 进入页面默认选择输入框，键盘会弹起
            autofocus: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                // 圆角
                borderRadius: BorderRadius.circular(30),
                // 去掉四周自带的边框
                borderSide: BorderSide.none,
              ),
            ),
          ),
          height: ScreenAdapter.height(68),
          decoration: BoxDecoration(
            color: Color.fromRGBO(233, 233, 233, 0.8),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        actions: <Widget>[
          InkWell(
            child: Container(
              height: ScreenAdapter.height(68),
              width: ScreenAdapter.width(80),
              child: Row(
                children: <Widget>[
                  Text("搜索"),
                ],
              ),
            ),
            onTap: () {
              print("搜索按钮");
            },
          )
        ],
      ),
      body: Center(
        child: Text("搜索"),
      ),
    );
  }
}
