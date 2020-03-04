import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';
import '../../model/ProductContentModel.dart';

// // 引入状态管理库 和自己创建的状态文件
// import 'package:provider/provider.dart';
// import '../../provider/Cart.dart';

// 购物车 数量子组件

class CartNum extends StatefulWidget {
  ProductContentItem _productContent;
  CartNum(this._productContent, {Key key}) : super(key: key);

  @override
  _CartNumState createState() => _CartNumState();
}

class _CartNumState extends State<CartNum> {
  ProductContentItem _productContent;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 初始化 接收父组件传入的 商品参数
    this._productContent = widget._productContent;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenAdapter.width(168),
      decoration: BoxDecoration(
        border: Border.all(
          width: ScreenAdapter.width(2),
          color: Colors.black12,
        ),
      ),
      child: Row(
        children: <Widget>[
          _leftBtn(),
          _centerArea(),
          _rightBtn(),
        ],
      ),
    );

    //     // 获取状态管理内的状态类
    // var cartProvider = Provider.of<Cart>(context);
    // return Column(
    //   children: <Widget>[
    //     Text("${cartProvider.cartNum}")
    //   ],
    // );
  }

  //左侧按钮

  Widget _leftBtn() {
    return InkWell(
      onTap: () {
        if (this._productContent.count > 1) {
          setState(() {
            this._productContent.count = this._productContent.count - 1;
          });
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: ScreenAdapter.width(45),
        height: ScreenAdapter.height(45),
        child: Text("-"),
      ),
    );
  }

  //右侧按钮
  Widget _rightBtn() {
    return InkWell(
      onTap: () {
        setState(() {
          this._productContent.count = this._productContent.count + 1;
        });
      },
      child: Container(
        alignment: Alignment.center,
        width: ScreenAdapter.width(45),
        height: ScreenAdapter.height(45),
        child: Text("+"),
      ),
    );
  }

//中间
  Widget _centerArea() {
    return Container(
      alignment: Alignment.center,
      width: ScreenAdapter.width(70),
      decoration: BoxDecoration(
          border: Border(
        left: BorderSide(width: ScreenAdapter.width(2), color: Colors.black12),
        right: BorderSide(width: ScreenAdapter.width(2), color: Colors.black12),
      )),
      height: ScreenAdapter.height(45),
      child: Text("${this._productContent.count}"),
    );
  }
}
