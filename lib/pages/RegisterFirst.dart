import 'package:flutter/material.dart';
import '../services/ScreenAdapter.dart';
import '../widget/JdText.dart';
import '../widget/JdButton.dart';
import '../config/Config.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

// 注册 步骤一
class RegisterFirstPage extends StatefulWidget {
  RegisterFirstPage({Key key}) : super(key: key);

  @override
  _RegisterFirstPageState createState() => _RegisterFirstPageState();
}

class _RegisterFirstPageState extends State<RegisterFirstPage> {
  String tel = "";

  // 下一步 请求接口
  sendCode() async {
    // 验证手机号 正则写法与 js 一样
    // ^1必须 1 开始
    // \d{10} : 0-9数字
    // $ : 结尾符号
    RegExp reg = new RegExp(r"^1\d{10}$");

    if (reg.hasMatch(this.tel)) {
      var api = '${Config.domain}api/sendCode';
      var response = await Dio().post(api, data: {"tel": this.tel});

      if (response.data["success"]) {
        print(response); //演示期间服务器直接返回  给手机发送的验证码
        Navigator.pushNamed(context, '/registerSecond',
            arguments: {"tel": this.tel});
      } else {
        // 提示失败
        Fluttertoast.showToast(
          msg: '${response.data["message"]}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: '手机号格式不对',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("用户注册-第一步"),
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 50),
            JdText(
              text: "请输入手机号",
              onChanged: (value) {
                // print(value);
                 this.tel = value;
              },
            ),
            SizedBox(height: 20),
            JdButton(
              text: "下一步",
              color: Colors.red,
              height: 74,
              cb: sendCode,
            )
          ],
        ),
      ),
    );
  }
}
