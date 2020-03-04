import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';

// 引入状态管理库 和自己创建的状态文件
import 'package:provider/provider.dart';
import '../../provider/Counter.dart';

// 我的页面
class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    // 获取状态管理内的状态类
    // var counterProvider = Provider.of<Counter>(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("用户中心"),
      // ),
      body: ListView(
        children: <Widget>[
          Container(
            height: ScreenAdapter.height(220),
            width: double.infinity,
            decoration: BoxDecoration(
              // 背景图片
              image: DecorationImage(
                  image: AssetImage('images/user_bg.jpg'), fit: BoxFit.cover),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ClipOval(
                    child: Image.asset(
                      'images/user.png',
                      fit: BoxFit.cover,
                      // 图片高宽 直接设置无效，需要配合 ClipOval
                      width: ScreenAdapter.width(100),
                      height: ScreenAdapter.height(100),
                    ),
                  ),
                ),

                // 登录前
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, '/loain');
                    },
                    child: Text("登录/注册", style: TextStyle(color: Colors.white)),
                  ),
                ),

                // // 登录后
                // Expanded(
                //   flex: 1,
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: <Widget>[
                //       Text(
                //         "用户名：124124125",
                //         style: TextStyle(
                //             color: Colors.white,
                //             fontSize: ScreenAdapter.size(32)),
                //       ),
                //       Text(
                //         "普通会员",
                //         style: TextStyle(
                //             color: Colors.white,
                //             fontSize: ScreenAdapter.size(24)),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.assignment, color: Colors.red),
            title: Text("全部订单"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment, color: Colors.green),
            title: Text("待付款"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.local_car_wash, color: Colors.orange),
            title: Text("待收货"),
          ),
          Container(
              width: double.infinity,
              height: 10,
              color: Color.fromRGBO(242, 242, 242, 0.9)),
          ListTile(
            leading: Icon(Icons.favorite, color: Colors.lightGreen),
            title: Text("我的收藏"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.people, color: Colors.black54),
            title: Text("在线客服"),
          ),
          Divider(),
        ],
      ),
    );
  }
}
