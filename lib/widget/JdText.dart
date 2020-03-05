import 'package:flutter/material.dart';
import '../services/ScreenAdapter.dart';

// 封装输入框
class JdText extends StatelessWidget {
  final String text;
  final bool password;
  final Object onChanged;
  final int maxLines;
  final double height;
  JdText(
      {Key key,
      this.text = "输入内容",
      this.password = false,
      this.onChanged = null,
      this.maxLines = 1,
      this.height = 68})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        maxLines: this.maxLines,
        // 输入框类型，密码框还是普通文本框，true 为密码框
        obscureText: this.password,
        decoration: InputDecoration(
          // 默认显示文本
          hintText: this.text,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none),
        ),
        //根据需要传入事件
        onChanged: this.onChanged,
      ),
      height: ScreenAdapter.height(this.height),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.black12),
        ),
      ),
    );
  }
}
