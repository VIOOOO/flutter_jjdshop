import 'package:flutter/material.dart';

// 引入状态管理库 和自己创建的状态文件
import 'package:provider/provider.dart';
import '../../provider/Cart.dart';

// 购物车 数量子组件

class CartNum extends StatefulWidget {
  CartNum({Key key}) : super(key: key);

  @override
  _CartNumState createState() => _CartNumState();
}

class _CartNumState extends State<CartNum> {
  @override
  Widget build(BuildContext context) {
        // 获取状态管理内的状态类
    var cartProvider = Provider.of<Cart>(context);
    return Column(
      children: <Widget>[
        Text("${cartProvider.cartNum}")
      ],
    );
  }
}
