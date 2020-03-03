import 'package:flutter/material.dart';
import 'dart:convert';
import '../services/Storage.dart';

// 存放购物车的共享数据
// 创建方法继承 ChangeNotifier
class Cart with ChangeNotifier {
  // 创建状态 在不同组件之间实现共享
  List _cartList = [];
  // 全选
  bool _isCheckedAll = false;
  // 总价
  double _allPrice = 0;

  // 获取状态 让外部通过 cartList 可以拿到 私有变量  _cartList 的数据
  List get cartList => this._cartList;
  bool get isCheckedAll => this._isCheckedAll;
  double get allPrice => this._allPrice;

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
    // 获取全选的状态
    this._isCheckedAll = this.isCheckAll();
    // 计算总价
    this.computeAllPrice();

    // 通知页面刷新数据
    notifyListeners();
  }

  // 更新数据
  updateCartList() {
    this.init();
  }

  // 保存更改的数据
  itemCountChange() {
    Storage.setString('cartList', json.encode(this._cartList));
    // 计算总价
    this.computeAllPrice();
    // 通知页面刷新数据
    notifyListeners();
  }

  // 全选 反选
  checkAll(value) {
    for (var i = 0; i < this._cartList.length; i++) {
      this._cartList[i]["checked"] = value;
    }
    this._isCheckedAll = value;
    // 计算总价
    this.computeAllPrice();

    Storage.setString('cartList', json.encode(this._cartList));
    // 通知页面刷新数据
    notifyListeners();
  }

  // 判断是否全选
  bool isCheckAll() {
    if (this._cartList.length > 0) {
      // 若有一个没有选，则不是全选
      for (var i = 0; i < this._cartList.length; i++) {
        if (this._cartList[i]["checked"] == false) {
          return false;
        }
      }
      return true;
    }
    return false;
  }

  // 监听每一线项的选中事件
  itemChage() {
    if (this.isCheckAll() == true) {
      this._isCheckedAll = true;
    } else {
      this._isCheckedAll = false;
    }
    // 计算总价
    this.computeAllPrice();

    Storage.setString('cartList', json.encode(this._cartList));
    // 通知页面刷新数据
    notifyListeners();
  }

  // 计算总价
  computeAllPrice() {
    double tempAllPrice = 0;
    for (var i = 0; i < this._cartList.length; i++) {
      if (this._cartList[i]["checked"] == true) {
        tempAllPrice += this._cartList[i]["price"] * this._cartList[i]["count"];
      }
    }
    this._allPrice = tempAllPrice;
    // 通知页面刷新数据
    notifyListeners();
  }

  //删除数据
  removeItem() {
    //  1        2
    // ['1111','2222','333333333','4444444444']
    // 错误的写法 
    // 此方法删除多个数据时候，依据索引值删错元素，但每删除一个元素列表内索引会改变，会导致后面删错数据
    // for (var i = 0; i < this._cartList.length; i++) {
    //   if (this._cartList[i]["checked"] == true) {
    //      this._cartList.removeAt(i);
    //   }
    // }

    List tempList = [];
    // 保存下 没打钩的数据，重新保存到缓存
    for (var i = 0; i < this._cartList.length; i++) {
      if (this._cartList[i]["checked"] == false) {
        tempList.add(this._cartList[i]);
      }
    }
    this._cartList = tempList;
    //计算总价
    this.computeAllPrice();
    Storage.setString("cartList", json.encode(this._cartList));
    notifyListeners();
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
