import 'dart:convert';
import 'package:crypto/crypto.dart';

// 签名验证
class SignServices {
  static getSign(json) {
    // // 请求参数
    // Map addressListAttr = {
    //   "uid": '1',
    //   "age": 10,
    //   "salt": 'xxxxxxxxxxxxxx' //私钥
    // };
    // 获取 key 转为数组
    List attrKeys = json.keys.toList();
    //排序  ASCII 字符顺序进行升序排列
    attrKeys.sort();
    // print('查看 SignServices：');
    // print(attrKeys);
    String str = '';
    for (var i = 0; i < attrKeys.length; i++) {
      str += "${attrKeys[i]}${json[attrKeys[i]]}";
    }
    // print(str);

    // 需要和服务器端 对比生成的MD5 是否一样
    // 生成签名
    // print(md5.convert(utf8.encode(str)));
    // 本身反回对象类型，需要转为 字符串类型，当前接口传值需要字符串类型
    return md5.convert(utf8.encode(str)).toString();
  }
}
