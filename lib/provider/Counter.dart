import 'package:flutter/material.dart';

// 创建方法继承 ChangeNotifier
class Counter with ChangeNotifier {
  // 创建状态 在不同组件之间实现共享
  int _count = 0;

  // 若初始化就希望能赋值 可以放入构造函数里面
  // 在构造函数内 可以获取本地存储的值进行赋值
  Counter() {
    this._count = 10;
  }

  // 获取状态 让外部通过 count 拿到 私有变量 _count 的数据
  int get count => _count;

  // 更新状态
  incCount() {
    this._count++;
    // 改变状态后 通知其他页面刷新数据
    notifyListeners();
  }
}
