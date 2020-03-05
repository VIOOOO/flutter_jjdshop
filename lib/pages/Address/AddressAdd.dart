import 'package:flutter/material.dart';
import 'package:city_pickers/city_pickers.dart';
import '../../services/ScreenAdapter.dart';
import '../../widget/JdText.dart';
import '../../widget/JdButton.dart';

import '../../services/UserServices.dart';
import '../../services/SignServices.dart';

import '../../config/Config.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../services/EventBus.dart';


// 增加收货地址
class AddressAddPage extends StatefulWidget {
  AddressAddPage({Key key}) : super(key: key);

  @override
  _AddressAddPageState createState() => _AddressAddPageState();
}

class _AddressAddPageState extends State<AddressAddPage> {
  String area = '';
  String name = '';
  String phone = '';
  String address = '';

  // 监听页面销毁
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // 新增收货地址页面销毁时候 进行事件广播，通知地址列表页面刷新数据
    eventBus.fire(new AddressEvent("增加成功...."));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("增加收货地址"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20),
            JdText(
              text: "收货人姓名",
              onChanged: (value) {
                this.name = value;
              },
            ),
            SizedBox(height: 10),
            JdText(
              text: "收货人电话",
              onChanged: (value) {
                this.phone = value;
              },
            ),
            SizedBox(height: 10),
            // 地址多级联动弹出窗
            Container(
              padding: EdgeInsets.only(left: 5),
              height: ScreenAdapter.height(68),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: Colors.black12),
                ),
              ),
              child: InkWell(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.add_location),
                    this.area.length > 0
                        ? Text(
                            '${this.area}',
                            style: TextStyle(color: Colors.black54),
                          )
                        : Text(
                            '省/市/区',
                            style: TextStyle(color: Colors.black54),
                          )
                  ],
                ),
                onTap: () async {
                  Result result = await CityPickers.showCityPicker(
                    context: context,
                    cancelWidget: Text(
                      "取消",
                      style: TextStyle(color: Colors.blue),
                    ),
                    confirmWidget: Text(
                      "确定",
                      style: TextStyle(color: Colors.blue),
                    ),
                  );

                  // print(result);
                  if (result != null) {
                    setState(() {
                      this.area =
                          "${result.provinceName}/${result.cityName}/${result.areaName}";
                    });
                  }
                },
              ),
            ),
            SizedBox(height: 10),
            JdText(
              text: "详细地址",
              maxLines: 4,
              height: 200,
              onChanged: (value) {
                this.address = "${this.area} ${value}";
              },
            ),
            SizedBox(height: 10),
            SizedBox(height: 40),
            JdButton(
              text: "增加",
              color: Colors.red,
              cb: () async {
                // 获取用户信息
                List userinfo = await UserServices.getUserInfo();
                // print(userinfo);

                // 生成要签名的 Map 对象
                var tempJson = {
                  "uid": userinfo[0]["_id"],
                  "name": this.name,
                  "phone": this.phone,
                  "address": this.address,
                  "salt": userinfo[0]["salt"]
                };

                // 生成签名
                var sign = SignServices.getSign(tempJson);
                // print(sign);

                // 发起请求
                var api = '${Config.domain}api/addAddress';
                var result = await Dio().post(api, data: {
                  "uid": userinfo[0]["_id"],
                  "name": this.name,
                  "phone": this.phone,
                  "address": this.address,
                  "sign": sign
                });
                // print(result);

                if (result.data["success"]) {
                  Fluttertoast.showToast(
                    msg: '${result.data["message"]}',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                  );
                  // 反回上一页
                  Navigator.pop(context);
                } else {
                  Fluttertoast.showToast(
                    msg: '${result.data["message"]}',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
