import 'dart:convert';
import 'Storage.dart';
import '../config/Config.dart';

// 购物车服务类 处理购物车逻辑
class CartServices {
  static addCart(item) async {
    //把对象转换成Map类型的数据
    item = CartServices.formatCartData(item);
    // print(item);
    // {_id: 5a0425bc010e711234661439, title: 磨砂牛皮男休闲鞋-有属性, price: 688, selectedAttr: 牛皮 ,系带,黄色, count: 6, pic: public\upload\RinsvExKu7Ed-ocs_7W1DxYO.png, checked: true}

    /*
      加入购物车流程：
      1、获取本地存储的cartList数据
      2、判断cartList是否有数据
            有数据：
                1、判断购物车有没有当前数据：
                        有当前数据：
                            1、让购物车中的当前数据数量 等于以前的数量+现在的数量
                            2、重新写入本地存储

                        没有当前数据：
                            1、把购物车cartList的数据和当前数据拼接，拼接后重新写入本地存储。

            没有数据：
                1、把当前商品数据以及属性数据放在数组中然后写入本地存储


              // 保存的数据格式
                List list=[
                  {"_id": "1", 
                    "title": "磨砂牛皮男休闲鞋-有属性", 
                    "price": 688, 
                    "selectedAttr": "牛皮 ,系带,黄色", 
                    "count": 4, 
                    "pic":"public\upload\RinsvExKu7Ed-ocs_7W1DxYO.png",
                    "checked": true
                  },  
                    {"_id": "2", 
                    "title": "磨xxxxxxxxxxxxx", 
                    "price": 688, 
                    "selectedAttr": "牛皮 ,系带,黄色", 
                    "count": 2, 
                    "pic":"public\upload\RinsvExKu7Ed-ocs_7W1DxYO.png",
                    "checked": true
                  }              
                  
                ];

      */

    try {
      // 获取本地存储的数据，若没有数据会报错
      List cartListData = json.decode(await Storage.getString('cartList'));

      // 循环遍历数据，判断数据中是否已经有存入的商品
      bool hasData = cartListData.any((value) {
        return value['_id'] == item['_id'] &&
            value['selectedAttr'] == item['selectedAttr'];
      });

      // 缓存中有商品，属性相同如果有则加1，属性不同则拼接数据存入
      if (hasData) {
        for (var i = 0; i < cartListData.length; i++) {
          if (cartListData[i]['_id'] == item['_id'] &&
              cartListData[i]['selectedAttr'] == item['selectedAttr']) {
            cartListData[i]["count"] = cartListData[i]["count"] + 1;
          }
        }
        await Storage.setString('cartList', json.encode(cartListData));
      } else {
        cartListData.add(item);
        await Storage.setString('cartList', json.encode(cartListData));
      }
    } catch (e) {
      // 若没有数据 ，则将数据存入
      List tempList = [];
      tempList.add(item);
      // 将数据转换为 字符串存储在本地
      await Storage.setString('cartList', json.encode(tempList));
    }
  }

  // 过滤数据 将实例转为 Map 对象
  static formatCartData(item) {
    // 处理图片
    String pic = item.pic;
    pic = Config.domain + pic.replaceAll('\\', '/');

    // 定义一个空 Map 类型对象
    final Map data = new Map<String, dynamic>();
    // 在对象内增加数据
    data['_id'] = item.sId;
    data['title'] = item.title;
    data['price'] = item.price;
    data['selectedAttr'] = item.selectedAttr;
    data['count'] = item.count;
    data['pic'] = pic;
    //是否选中
    data['checked'] = true;
    return data;
  }
}
