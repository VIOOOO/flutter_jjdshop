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
        body: Container(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                // 字体样式 使用app 自带的标题 Theme.of(context).textTheme.title
                child: Text("热搜", style: Theme.of(context).textTheme.title),
              ),
              Divider(),
              Wrap(
                // 使用行组件，内部子元素也不需要设置宽度，超出的可以自动换行
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(233, 233, 233, 0.9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text("女装"),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text("笔记本电脑"),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text("女装111"),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                // 字体样式 使用app 自带的标题 Theme.of(context).textTheme.title
                child: Text("历史记录", style: Theme.of(context).textTheme.title),
              ),
              Divider(),
              Column(
                children: <Widget>[
                  ListTile(
                    title: Text("男装43333333331"),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("男装"),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("手机"),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("鞋子"),
                  ),
                ],
              ),
              SizedBox(height: 100),
              InkWell(
                onTap: () {
                  print("清理历史记录");
                },
                child: Container(
                  width: ScreenAdapter.width(400),
                  height: ScreenAdapter.height(64),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromRGBO(233, 233, 233, 1),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.delete),
                      Text("清空历史搜索"),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
