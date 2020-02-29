import 'package:flutter/material.dart';
import '../services/ScreenAdapter.dart';

// 类名称和组件名称保持首字母大写，文件夹可以大写也可以小写，如果声明的文件不是类，而是方法，文件首字母小写
import 'ProductContent/ProductContentFirst.dart';
import 'ProductContent/ProductContentSecond.dart';
import 'ProductContent/ProductContentThird.dart';

import '../widget/JdButton.dart';

// 产品详情呀

class ProductContentPage extends StatefulWidget {
  final Map arguments;
  ProductContentPage({Key key, this.arguments}) : super(key: key);

  @override
  _ProductContentPageState createState() => _ProductContentPageState();
}

class _ProductContentPageState extends State<ProductContentPage> {
  @override
  Widget build(BuildContext context) {
    // DefaultTabController 分页组件和 TabBer 组件 TabBarView 组件配合使用
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: ScreenAdapter.width(400),
                  child: TabBar(
                    // 下划线颜色
                    indicatorColor: Colors.red,
                    // 下划线长度
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: <Widget>[
                      Tab(
                        child: Text("商品"),
                      ),
                      Tab(
                        child: Text("详情"),
                      ),
                      Tab(
                        child: Text("评价"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.more_horiz),
                onPressed: () {
                  // 右上角下拉拉菜单
                  showMenu(
                    // 上下文的对象
                    context: context,
                    // 显示位置
                    position: RelativeRect.fromLTRB(
                        ScreenAdapter.width(600), 76, 10, 0),
                    // 内容
                    items: [
                      PopupMenuItem(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.home),
                            Text("首页"),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.search),
                            Text("搜索"),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.share),
                            Text("分享"),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
          body: Stack(
            children: <Widget>[
              // 页面内容
              TabBarView(
                children: <Widget>[
                  ProductContentFrist(),
                  ProductContentSecond(),
                  ProductContentThird(),
                ],
              ),
              // 底部固定浮动导航
              Positioned(
                width: ScreenAdapter.width(750),
                height: ScreenAdapter.width(88),
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.black26,
                        width: 1,
                      ),
                    ),
                    color: Colors.white,
                  ),
                  child: Row(
                    // 底部固定菜单， 左边固定宽，右边两个自适应按钮
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: ScreenAdapter.height(10)),
                        width: 100,
                        height: ScreenAdapter.width(88),
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.shopping_cart),
                            Text("购物车"),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: JdButton(
                          color: Color.fromRGBO(253, 1, 0, 0.9),
                          text: "加入购物车",
                          cb: () {
                            print("加入购物车");
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: JdButton(
                          color: Color.fromRGBO(225, 165, 0, 0.9),
                          text: "立即购买",
                          cb: () {
                            print("立即购买");
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
