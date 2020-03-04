import 'package:flutter/material.dart';
import '../services/ScreenAdapter.dart';
import '../widget/JdText.dart';
import '../widget/JdButton.dart';

// 登录页面
class LoainPage extends StatefulWidget {
  LoainPage({Key key}) : super(key: key);

  @override
  _LoainPageState createState() => _LoainPageState();
}

class _LoainPageState extends State<LoainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 修改返回箭头为 X icon
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // title: Text("登录页面"),
        actions: <Widget>[
          FlatButton(
            child: Text("客服"),
            onPressed: () {},
          )
        ],
      ),
      // 使用 ListView 避免在在页面弹出键盘时候页面长度不足，可以上下滑动
      body: Container(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        child: ListView(
          children: <Widget>[
            // Logo
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 30),
                height: ScreenAdapter.width(160),
                width: ScreenAdapter.width(160),
                // child: Image.asset('images/login.png'),
                child: Image.network(
                    'https://www.itying.com/images/flutter/list5.jpg',
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 30),
            // 封装的输入框
            JdText(
              text: "请输入用户名",
              onChanged: (value) {
                print(value);
              },
            ),
            SizedBox(height: 10),
            JdText(
              text: "请输入密码",
              password: true,
              onChanged: (value) {
                print(value);
              },
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(ScreenAdapter.width(20)),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('忘记密码'),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/registerFirst');
                      },
                      child: Text('新用户注册'),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            JdButton(
              text: "登录",
              color: Colors.red,
              height: 74,
              cb: () {
                print("登录");
              },
            )
          ],
        ),
      ),
    );
  }
}
