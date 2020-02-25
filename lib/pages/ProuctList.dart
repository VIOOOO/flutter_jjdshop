import 'package:flutter/material.dart';
import '../services/ScreenAdaper.dart';
import '../config/Config.dart';
import 'package:dio/dio.dart';

// 商品列表
class ProuctListPage extends StatefulWidget {
  Map arguments;

  ProuctListPage({Key key, this.arguments}) : super(key: key);

  @override
  _ProuctListPageState createState() => _ProuctListPageState();
}

class _ProuctListPageState extends State<ProuctListPage> {
  // 全局声明 GlobalKey 给组件命名，用于打开右侧抽屉组件
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // 商品列表
  Widget _productListWidget() {
    return Container(
      padding: EdgeInsets.all(10),
      // 预留顶部位置给二级导航条，让页面滚动不会互相叠加
      margin: EdgeInsets.only(top: ScreenAdaper.height(80)),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: ScreenAdaper.width(180),
                    height: ScreenAdaper.height(180),
                    child: Image.network(
                      'https://www.itying.com/images/flutter/list8.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: ScreenAdaper.height(180),
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "戴尔(DELL)灵越3670 英特尔酷睿i5 高性能 台式电脑整机(九代i5-9400 8G 256G)",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                height: ScreenAdaper.height(36),
                                margin: EdgeInsets.only(right: 10),
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),

                                //注意 如果Container里面加上decoration属性，这个时候color属性必须得放在BoxDecoration
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromRGBO(230, 230, 230, 0.9),
                                ),

                                child: Text("4g"),
                              ),
                              Container(
                                height: ScreenAdaper.height(36),
                                margin: EdgeInsets.only(right: 10),
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromRGBO(230, 230, 230, 0.9),
                                ),
                                child: Text("126"),
                              ),
                            ],
                          ),
                          Text(
                            "￥999",
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Divider(height: 20),
            ],
          );
        },
        itemCount: 10,
      ),
    );
  }

// 自定义二级导航 筛选导航
  Widget _subHeaderWidget() {
    return Positioned(
      top: 0,
      height: ScreenAdaper.height(80),
      width: ScreenAdaper.width(750),
      child: Container(
        width: ScreenAdaper.width(750),
        height: ScreenAdaper.height(80),
        // color: Colors.red,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Color.fromRGBO(233, 233, 233, 0.9),
            ),
          ),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, ScreenAdaper.height(16), 0, ScreenAdaper.height(16)),
                  child: Text(
                    "综合",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
                onTap: () {},
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, ScreenAdaper.height(16), 0, ScreenAdaper.height(16)),
                  child: Text("销量", textAlign: TextAlign.center),
                ),
                onTap: () {},
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, ScreenAdaper.height(16), 0, ScreenAdaper.height(16)),
                  child: Text("价格", textAlign: TextAlign.center),
                ),
                onTap: () {},
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, ScreenAdaper.height(16), 0, ScreenAdaper.height(16)),
                  child: Text("筛选", textAlign: TextAlign.center),
                ),
                onTap: () {
                  // 打开右边侧边栏
                  _scaffoldKey.currentState.openEndDrawer();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Scaffold(
      // 给组件定义一个名字 ID
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('商品列表'),
        // // 将导航条内 左边的默认添加的图标替换掉
        // leading: Text(""),

        // 将导航条内 左边的默认添加的图标替换掉
        actions: <Widget>[Text("")],
      ),
      // 右侧抽屉组件
      endDrawer: Drawer(
        child: Container(
          child: Text("实现筛选功能"),
        ),
      ),
      // body: Text("${widget.arguments}"),
      body: Stack(
        // 定位组件
        children: <Widget>[
          // 页面内容
          _productListWidget(),
          // 顶部二级导航条 固定位置
          _subHeaderWidget()
        ],
      ),
    );
  }
}
