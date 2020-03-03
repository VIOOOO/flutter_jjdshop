import 'package:flutter/material.dart';
import 'dart:convert';
import '../services/Storage.dart';

// 存放购物车的共享数据
// 创建方法继承 ChangeNotifier
class Cart with ChangeNotifier {
  // 创建状态 在不同组件之间实现共享
  List _cartList = [];

  // 获取状态 让外部通过 cartList 可以拿到 私有变量  _cartList 的数据
  List get cartList => this._cartList;

  Cart() {
    this.init();
  }

  // 初始化时候获取购物车数据
  init() async {
    try {
      List cartListData = json.decode(await Storage.getString('cartList'));
      this._cartList = cartListData;
    } catch (e) {
      this._cartList = [];
    }
    // 通知刷新数据
    notifyListeners();
  }
  updateCartList(){
    this.init();
  }
}

// // 创建方法继承 ChangeNotifier
// class Cart with ChangeNotifier {
//   // 创建状态 在不同组件之间实现共享
//   List _cartList = [];
//   // int _cartNum = 0;

//   // 获取状态 让外部通过 cartList 可以拿到 私有变量  _cartList 的数据
//   List get cartList => this._cartList;
//   int get cartNum => this._cartList.length;

//   // 添加
//   addData(value) {
//     this._cartList.add(value);
//     // 改变状态后 通知其他页面刷新数据
//     notifyListeners();
//   }

//   // 删除
//   deleteData(value) {
//     this._cartList.remove(value);
//     // 改变状态后 通知其他页面刷新数据
//     notifyListeners();
//   }
// }
