import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';
import './CartNum.dart';

// 引入状态管理库 和自己创建的状态文件
import 'package:provider/provider.dart';
import '../../provider/Cart.dart';

// 购物车 列表页面子组件
class CartItem extends StatefulWidget {
  // 接收出入的数据
  Map _itemData;
  CartItem(this._itemData, {Key key}) : super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  Map _itemData;

  @override
  Widget build(BuildContext context) {
    // 获取父组件传入的值
    // 在购物车删除商品时候， build 方法会重新渲染，但是 initState 不会触发，导致数据不更新，
    // 购物车会感觉删错东西，其实删对的，刷新页面可以看见，所以 将this._itemData 放在刷新的 build 立面重新赋值
    this._itemData = widget._itemData;

    var cartProvider = Provider.of<Cart>(context);

    return Container(
      height: ScreenAdapter.height(200),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenAdapter.width(60),
            child: Checkbox(
              value: _itemData["checked"],
              onChanged: (val) {
                // 选择和取消选择
                setState(() {
                  _itemData["checked"] = !_itemData["checked"];
                });
                cartProvider.itemChage();
              },
              activeColor: Colors.pink,
            ),
          ),
          Container(
            width: ScreenAdapter.width(160),
            child: Image.network(
                // "https://www.itying.com/images/flutter/list2.jpg",
                "${_itemData["pic"]}",
                fit: BoxFit.cover),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("${_itemData["title"]}", maxLines: 2),
                  Text("${_itemData["selectedAttr"]}", maxLines: 1),
                  Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("￥${_itemData["price"]}",
                            style: TextStyle(color: Colors.red)),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CartNum(_itemData),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
