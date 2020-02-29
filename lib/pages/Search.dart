import 'package:flutter/material.dart';
import '../services/SearchServices.dart';
import '../services/ScreenAdapter.dart';

// 搜索页面
class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // 定义接收搜索框输入的内容
  var _keywords;
  // 接收历史记录
  List _historyListData = [];

  @override
  void initState() {
    super.initState();
    this._getHistoryData();
  }

  //获取历史记录数据
  _getHistoryData() async {
    var _historyListData = await SearchServices.getHistoryList();
    setState(() {
      this._historyListData = _historyListData;
    });
  }

  // 弹出框
  _showAlertDialog(keywords) async {
    var result = await showDialog(
        barrierDismissible: false, //表示点击灰色背景的时候是否消失弹出框
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示信息!"),
            content: Text("您确定要删除吗?"),
            actions: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: () {
                  print("取消");
                  Navigator.pop(context, 'Cancle');
                },
              ),
              FlatButton(
                child: Text("确定"),
                onPressed: () async {
                  //注意异步
                  await SearchServices.removeHistoryData(keywords);
                  this._getHistoryData();
                  Navigator.pop(context, "Ok");
                },
              )
            ],
          );
        });

    //  print(result);
  }

  // 封装历史记录组件
  Widget _historyListWidget() {
    // print("获取历史记录");
    // print(this._historyListData);
    if (this._historyListData.length > 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            // 字体样式 使用app 自带的标题 Theme.of(context).textTheme.title
            child: Text("历史记录", style: Theme.of(context).textTheme.title),
          ),
          Divider(),
          Column(
            children: this._historyListData.map((value) {
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Text("${value}"),
                    //  长按删除
                    onLongPress: ()  {
                       this._showAlertDialog("${value}");
                    },
                  ),
                  Divider(),
                ],
              );
            }).toList(),
          ),
          SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  // print("清理历史记录");
                  SearchServices.clearHistoryList();
                  // 重新获取数据
                  this._getHistoryData();
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
          )
        ],
      );
    } else {
      return Text("");
    }
  }

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
            // 监听接收输入框的内容
            onChanged: (value) {
              this._keywords = value;
            },
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
              // 保存搜索记录
              SearchServices.setHistoryData(this._keywords);

              // 查询结果并跳转到产品列表页面
              Navigator.pushReplacementNamed(context, '/productListPage',
                  arguments: {"keywords": this._keywords});
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
            // 历史记录
            _historyListWidget(),
          ],
        ),
      ),
    );
  }
}
