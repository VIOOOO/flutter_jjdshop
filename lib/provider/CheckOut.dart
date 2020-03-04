import 'package:flutter/material.dart';
import 'dart:convert';
import '../services/Storage.dart';

// 购物车结算
class CheckOut with ChangeNotifier {
  //购物车数据
  List _checkOutListData = [];
  List get checkOutListData => this._checkOutListData;

  changeCheckOutListData(data) {
    this._checkOutListData = data;
    // 通知页面刷新数据
    notifyListeners();
  }
}
