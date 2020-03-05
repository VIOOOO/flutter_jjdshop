import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';

import '../../services/UserServices.dart';
import '../../services/SignServices.dart';

import '../../config/Config.dart';
import 'package:dio/dio.dart';

import '../../services/EventBus.dart';

// 收货地址列表
class AddressListPage extends StatefulWidget {
  AddressListPage({Key key}) : super(key: key);

  @override
  _AddressListPageState createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  List addressList = [];

  @override
  void initState() {
    super.initState();
    this._getAddressList();

    // 监听新增收货地址页面的广播通知
    eventBus.on<AddressEvent>().listen((event) {
      print("监听到新增收货地址页面广播通知：");
      print(event.str);
      this._getAddressList();
    });
  }

  //监听页面销毁的事件
  dispose(){
    super.dispose();
    // 地址列表页面销毁时候， 通知结算页面修改默认收货地址
    eventBus.fire(new CheckOutEvent('改收货地址成功...'));
  }

  //获取收货地址列表
  _getAddressList() async {
    // 请求接口
    List userinfo = await UserServices.getUserInfo();

    // 获取要签名的参数
    var tempJson = {
      "uid": userinfo[0]['_id'],
      "salt": userinfo[0]["salt"],
    };

    // 签名
    var sign = SignServices.getSign(tempJson);

    // 发起请求
    var api =
        "${Config.domain}api/addressList?uid=${userinfo[0]['_id']}&sign=${sign}";
    var response = await Dio().get(api);
    // print(response.data["result"]);
    setState(() {
      this.addressList = response.data["result"];
    });
  }

  //修改默认收货地址
  _changeDefaultAddress(id) async {
    // 请求接口
    List userinfo = await UserServices.getUserInfo();

    // 获取要签名的参数
    var tempJson = {
      "uid": userinfo[0]['_id'],
      "id": id,
      "salt": userinfo[0]["salt"],
    };

    // 签名
    var sign = SignServices.getSign(tempJson);

    // 发起请求
    var api = "${Config.domain}api/changeDefaultAddress";
    var response = await Dio()
        .post(api, data: {"uid": userinfo[0]['_id'], "id": id, "sign": sign});
    print(response);
    // 返回
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("收货地址列表"),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            ListView.builder(
                itemCount: this.addressList.length,
                itemBuilder: (context, index) {
                  // 如果选中的 地址则前面有个 打钩
                  if (this.addressList[index]["default_address"] == 1) {
                    return Column(
                      children: <Widget>[
                        SizedBox(height: 20),
                        ListTile(
                          leading: Icon(Icons.check, color: Colors.red),
                          title: InkWell(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                      "${this.addressList[index]["name"]}  ${this.addressList[index]["phone"]}"),
                                  SizedBox(height: 10),
                                  Text("${this.addressList[index]["address"]}"),
                                ]),
                            onTap: () {
                              this._changeDefaultAddress(
                                  this.addressList[index]["_id"]);
                            },
                          ),
                          trailing: Icon(Icons.edit, color: Colors.blue),
                        ),
                        Divider(height: 20),
                      ],
                    );
                  } else {
                    return Column(
                      children: <Widget>[
                        SizedBox(height: 20),
                        ListTile(
                          title: InkWell(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                      "${this.addressList[index]["name"]}  ${this.addressList[index]["phone"]}"),
                                  SizedBox(height: 10),
                                  Text("${this.addressList[index]["address"]}"),
                                ]),
                            onTap: () {
                              this._changeDefaultAddress(
                                  this.addressList[index]["_id"]);
                            },
                          ),
                          trailing: Icon(Icons.edit, color: Colors.blue),
                        ),
                        Divider(height: 20),
                      ],
                    );
                  }
                }),
            Positioned(
              bottom: 0,
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(88),
              child: Container(
                padding: EdgeInsets.all(5),
                width: ScreenAdapter.width(750),
                height: ScreenAdapter.height(88),
                decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border(
                        top: BorderSide(width: 1, color: Colors.black26))),
                child: InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.add, color: Colors.white),
                      Text("增加收货地址", style: TextStyle(color: Colors.white))
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/addressAdd');
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
