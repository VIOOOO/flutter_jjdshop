import 'package:flutter/material.dart';

import 'Home.dart';
import 'Cart.dart';
import 'Category.dart';
import 'User.dart';

// 底部导航
class Tabs extends StatefulWidget {
  Tabs({Key key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 1;
  // tab 页面
  List _pageList = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    UserPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('jdshop'),
      ),
      // 配置 tabs 对应路由页面
      body: this._pageList[this._currentIndex],
      //  底部导航栏
      bottomNavigationBar: BottomNavigationBar(
        // 设置当前点击的 tabs
        currentIndex: this._currentIndex,
        // 修改点击的索引
        onTap: (index) {
          setState(() {
            this._currentIndex = index;
          });
        },
        // tab 超过3个时候需要添加该属性
        type: BottomNavigationBarType.fixed,
        // 选中的 tab 颜色
        fixedColor: Colors.red,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('首页'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text('分类'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text('购物车'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text('我的'),
          ),
        ],
      ),
    );
  }
}
