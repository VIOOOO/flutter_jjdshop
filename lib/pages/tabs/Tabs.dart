import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';

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
  int _currentIndex = 3;

  PageController _pageController;

  @override
  void initState() {
    super.initState();
    //保持页面状态 AutomaticKeepAliveClientMixin 页面控制器初始化
    this._pageController = new PageController(initialPage: this._currentIndex);
  }

  // tab 页面
  List<Widget> _pageList = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    UserPage(),
  ];
  @override
  Widget build(BuildContext context) {
    // 初始化屏幕适配
    ScreenAdapter.init(context);
    return Scaffold(
      // // 若不抽离单独配置导航，可以判断页面显示不同导航，抽离会更好
      // appBar: _currentIndex != 3
      //     ?
      //     : AppBar(
      //         title: Text("用户中心"),
      //       ),
      // 配置 tabs 对应路由页面
      // body: this._pageList[this._currentIndex],

      // // 保持页面状态 IndexedStack ,切换页面不需要等待数据请求加载，在小项目使用很方便
      // body: IndexedStack(
      //   index: this._currentIndex,
      //   // children 的类型为 Widget
      //   children: _pageList,
      // ),

      // 保持页面状态 AutomaticKeepAliveClientMixin
      //必须用 PageView 加载不同的页面
      body: PageView(
        controller: this._pageController,
        children: this._pageList,
        // 监听页面改变
        onPageChanged: (index) {
          setState(() {
            this._currentIndex = index;
          });
        },
        // 禁止 PageView 左右滑动
        physics: NeverScrollableScrollPhysics(),
      ),

      //  底部导航栏
      bottomNavigationBar: BottomNavigationBar(
        // 设置当前点击的 tabs
        currentIndex: this._currentIndex,
        // 修改点击的索引
        onTap: (index) {
          setState(() {
            this._currentIndex = index;
            // 使用保持页面状态 AutomaticKeepAliveClientMixin 后点击 tab 导航跳转需要使用 jumpToPage
            this._pageController.jumpToPage(index);
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
