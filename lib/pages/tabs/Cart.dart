import 'package:flutter/material.dart';
import '../../services/CartServices.dart';
import '../../services/UserServices.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../services/ScreenAdapter.dart';

// 引入状态管理库 和自己创建的状态文件
import 'package:provider/provider.dart';
// import '../../provider/Counter.dart';
import '../../provider/Cart.dart';
import '../../provider/CheckOut.dart';

import '../Cart/CartItem.dart';

// 购物车页面
class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // 编辑购物车开关
  bool _isEdit = false;

  var checkOutProvider;
  @override
  void initState() {
    super.initState();
    print("cart");
  }

  // 去结算
  doCheckOut() async {
    //1、获取购物车选中的数据
    List checkOutData = await CartServices.getCheckOutData();
    //2、保存购物车选中的数据在 provider 中，其他组件就可以获取该数据
    this.checkOutProvider.changeCheckOutListData(checkOutData);
    //3、购物车有没有选中的数据
    if (checkOutData.length > 0) {
      //4、判断用户有没有登录
      var loginState = await UserServices.getUserLoginState();
      if (loginState) {
        // 如果已经登录则跳转到结算页面
        Navigator.pushNamed(context, '/checkOut');
      } else {
        Fluttertoast.showToast(
          msg: '您还没有登录，请登录以后再去结算',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
        Navigator.pushNamed(context, '/login');
      }
    } else {
      Fluttertoast.showToast(
        msg: '购物车没有选中的数据',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    // 获取状态管理内的状态类
    // var counterProvider = Provider.of<Counter>(context);
    var cartProvider = Provider.of<Cart>(context);
    checkOutProvider = Provider.of<CheckOut>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("购物车"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.launch),
            onPressed: () {
              // 编辑购物车
              setState(() {
                this._isEdit = !this._isEdit;
              });
            },
          )
        ],
      ),
      body: cartProvider.cartList.length > 0
          ? Stack(
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    Column(
                        children: cartProvider.cartList.map((value) {
                      return CartItem(value);
                    }).toList()),
                    SizedBox(height: ScreenAdapter.height(100))
                  ],
                ),
                Positioned(
                  // 定位在底部
                  bottom: 0,
                  width: ScreenAdapter.width(750),
                  height: ScreenAdapter.height(78),
                  child: Container(
                    width: ScreenAdapter.width(750),
                    height: ScreenAdapter.height(78),
                    color: Colors.red,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(width: 1, color: Colors.black12)),
                        color: Colors.white,
                      ),
                      width: ScreenAdapter.width(750),
                      height: ScreenAdapter.height(78),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: ScreenAdapter.width(60),
                                  child: Checkbox(
                                    value: cartProvider.isCheckedAll,
                                    activeColor: Colors.pink,
                                    onChanged: (val) {
                                      // 全选 或反选
                                      cartProvider.checkAll(val);
                                    },
                                  ),
                                ),
                                Text("全选"),
                                SizedBox(width: 20),
                                // 如果为编辑购物车时候 隐藏总计价格
                                this._isEdit == false ? Text("合计:") : Text(""),
                                this._isEdit == false
                                    ? Text(
                                        "${cartProvider.allPrice}",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.red),
                                      )
                                    : Text(""),
                              ],
                            ),
                          ),
                          this._isEdit == false
                              ? Align(
                                  alignment: Alignment.centerRight,
                                  child: RaisedButton(
                                    child: Text("结算",
                                        style: TextStyle(color: Colors.white)),
                                    color: Colors.red,
                                    onPressed: doCheckOut,
                                  ),
                                )
                              : Align(
                                  alignment: Alignment.centerRight,
                                  child: RaisedButton(
                                    child: Text("删除",
                                        style: TextStyle(color: Colors.white)),
                                    color: Colors.red,
                                    onPressed: () {
                                      // 删除勾选的商品
                                      cartProvider.removeItem();
                                    },
                                  ),
                                )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Center(
              child: Text("购物车空空的..."),
            ),
    );

    // return Scaffold(
    //   // 浮动按钮
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () {
    //       // 调用状态组件内的方法 让创建的状态改变
    //       // 每一次状态改变都会通知当前页 重新 build
    //       counterProvider.incCount();
    //       // 给购物车列表增加数据 需要区分开数据避免一样 ，删除会报错
    //       cartProvider.addData("哈哈${counterProvider.count}");
    //     },
    //     child: Icon(Icons.add),
    //   ),
    //   body: Column(
    //     children: <Widget>[
    //       Center(
    //         child: Text(
    //           "${counterProvider.count}",
    //           style: TextStyle(fontSize: 50),
    //         ),
    //       ),
    //       Divider(
    //         height: 40,
    //       ),
    //       // 加载购物车子组件
    //       CartItem(),
    //       CartNum(),
    //     ],
    //   ),
    // );
  }
}
