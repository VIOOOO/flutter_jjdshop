import 'package:flutter/material.dart';

// 引入状态管理库 和自己创建的状态文件
import 'package:provider/provider.dart';
import '../../provider/Counter.dart';
import '../../provider/Cart.dart';

import '../Cart/CartItem.dart';
import '../Cart/CartNum.dart';

// 购物车页面
class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    // 获取状态管理内的状态类
    var counterProvider = Provider.of<Counter>(context);
    var cartProvider = Provider.of<Cart>(context);
    return Scaffold(
      // 浮动按钮
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 调用状态组件内的方法 让创建的状态改变
          // 每一次状态改变都会通知当前页 重新 build
          counterProvider.incCount();
          // 给购物车列表增加数据 需要区分开数据避免一样 ，删除会报错
          cartProvider.addData("哈哈${counterProvider.count}");
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Text(
              "${counterProvider.count}",
              style: TextStyle(fontSize: 50),
            ),
          ),
          Divider(
            height: 40,
          ),
          // 加载购物车子组件
          CartItem(),
          CartNum(),
        ],
      ),
    );
  }
}
