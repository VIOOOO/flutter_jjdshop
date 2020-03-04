import 'package:flutter/material.dart';
import '../services/ScreenAdapter.dart';

// 商品详情页面 按钮封装

class JdButton extends StatelessWidget {
  final Color color;
  final String text;
  final Object cb;
  final double height;
  JdButton({
    Key key,
    this.color = Colors.black,
    this.text = "按钮",
    this.cb = null,
    this.height = 68,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 初始化屏幕适配
    ScreenAdapter.init(context);
    return InkWell(
      onTap: this.cb,
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        height: ScreenAdapter.height(this.height),
        width: double.infinity,
        decoration: BoxDecoration(
          color: this.color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            "${this.text}",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
