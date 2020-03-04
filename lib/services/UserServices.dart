import '../services/Storage.dart';
import 'dart:convert';

// 用户信息处理类
class UserServices {
  // // 静态方法 可以直接访问，不需要这部分
  // List _userInfo;
  // List get userInfo => this._userInfo;
  //   // 获取用户信息
  // static getUserInfo() async {
  //   try {
  //     List userInfoData = json.decode(await Storage.getString('userInfo'));
  //     this._userInfo = userInfoData;
  //   } catch (e) {
  //     this._userInfo = [];
  //   }
  // }

  // 修改为静态方法，可以在外部 通过 . 访问
  // 获取用户信息
  static getUserInfo() async {
    List userinfo;
    try {
      List userInfoData = json.decode(await Storage.getString('userInfo'));
      userinfo = userInfoData;
    } catch (e) {
      userinfo = [];
    }
    return userinfo;
  }

  // 获取用户状态
  static getUserLoginState() async {
    // 获取用户信息
    var userInfo = await UserServices.getUserInfo();

    // 如果用户信息存在 返回 true
    if (userInfo.length > 0 && userInfo[0]["username"] != "") {
      return true;
    }
    return false;
  }

  // 退出登录
  static loginOut() {
    Storage.remove('userInfo');
  }
}
