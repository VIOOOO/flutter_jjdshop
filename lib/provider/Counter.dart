import 'package:flutter/material.dart';

// 创建方法继承 ChangeNotifier
class Counter with ChangeNotifier{

  // 创建状态 在不同组件之间实现共享
  int _count = 0;

  // 获取状态 让外部可以拿到 私有方法 _count
  int get count => _count;

  // 更新状态
  incCount(){

    this._count++;
    // 更新状态
    notifyListeners();
  }

}
