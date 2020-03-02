import 'package:flutter/material.dart';

// 引入状态管理库 和自己创建的状态文件
import 'package:provider/provider.dart';
import '../../provider/Cart.dart';

// 购物车 列表页面子组件

class CartItem extends StatefulWidget {
  CartItem({Key key}) : super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    // 获取状态管理内的状态类
    var cartProvider = Provider.of<Cart>(context);
    return cartProvider.cartList.length > 0
        ? Column(
            children: cartProvider.cartList.map((value) {
              return ListTile(
                title: Text("${value}"),
                trailing: InkWell(
                  onTap: () {
                    // 删除
                    cartProvider.deleteData(value);
                  },
                  child: Icon(Icons.delete),
                ),
              );
            }).toList(),
          )
        : Text("");
  }
}
