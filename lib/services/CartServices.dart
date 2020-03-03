// 购物车服务类 处理购物车逻辑
class CartServices {
  static addCart(item) {
    //把对象转换成Map类型的数据
    item = CartServices.formatCartData(item);
    // print(item);
    // {_id: 5a0425bc010e711234661439, title: 磨砂牛皮男休闲鞋-有属性, price: 688, selectedAttr: 牛皮 ,系带,黄色, count: 6, pic: public\upload\RinsvExKu7Ed-ocs_7W1DxYO.png, checked: true}
  }

  // 过滤数据 将实例转为 Map 对象
  static formatCartData(item) {
    // 定义一个空 Map 类型对象
    final Map data = new Map<String, dynamic>();
    // 在对象内增加数据
    data['_id'] = item.sId;
    data['title'] = item.title;
    data['price'] = item.price;
    data['selectedAttr'] = item.selectedAttr;
    data['count'] = item.count;
    data['pic'] = item.pic;
    //是否选中
    data['checked'] = true;
    return data;
  }
}
