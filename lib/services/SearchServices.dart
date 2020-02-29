import 'dart:convert';

import 'Storage.dart';

// 保存搜索过的内容

class SearchServices {
  static setHistoryData(keywords) async {
    /*
    1、获取本地存储里面的数据  (searchList)

    2、判断本地存储是否有数据

        2.1、如果有数据 
              1、读取本地存储的数据
              2、判断本地存储中有没有当前数据，
                  如果有不做操作、
                  如果没有当前数据,本地存储的数据和当前数据拼接后重新写入  

        2.2、如果没有数据
              直接把当前数据放在数组中写入到本地存储
      */

    //若拿不到数据会出现报错，则本地存储内没有
    try {
      // 将拿到的 String 转为 Map 类型
      List searchListData = json.decode(await Storage.getString('searchList'));
      // print("存入：");
      // print(searchListData);

      // 如果 里有查询的值，则返回 true
      var hasData = searchListData.any((v) {
        return v == keywords;
      });
      if (!hasData) {
        // 将数据拼接
        searchListData.add(keywords);
        // 存入缓存
        await Storage.setString('searchList', json.encode(searchListData));
      }
    } catch (e) {
      // 存储缓存没有的内容
      List tempList = new List();
      tempList.add(keywords);
      await Storage.setString('searchList', json.encode(tempList));
    }
  }

  // 获取数据
  static getHistoryList() async {
    // 如果有获取到 缓存数据则返回数据，如果没有则返回空数组
    try {
      List searchListData = json.decode(await Storage.getString('searchList'));
      return searchListData;
    } catch (e) {
      return [];
    }
  }

  // 清除数据
  static clearHistoryList() async {
    await Storage.remove('searchList');
  }

  // 删掉选定的历史记录、
  static removeHistoryData(keywords) async {
    List searchListData = json.decode(await Storage.getString('searchList'));
    searchListData.remove(keywords);
    await Storage.setString('searchList', json.encode(searchListData));
  }
}
