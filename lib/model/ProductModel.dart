// 商品列表集合 类模型
// 主要是处理 result 里面这些数据
class ProductModel {
  // 泛型定义接收处理的数据，使用下面的 ProductItemModel 进行约束格式
  List<ProductItemModel> result;

  ProductModel({this.result});
  // 循环遍历 Map 类型，拿到每一个 Map 值
  ProductModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = new List<ProductItemModel>();
      json['result'].forEach((v) {
        // 将循环遍历后的 通过 ProductItemModel 把对应的 Map 数据转换成  ProductItemModel 的一个实例，放入集合内
        result.add(new ProductItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// 该类里面是数据对应的类
class ProductItemModel {
  // 有下划线的类 会修改为驼峰写法
  String sId;
  String title;
  String cid;
  Object price; // 有些价格是 String 有些是 int ,修改为 Object 因为所有类型都继承 Object
  String oldPrice;
  String pic;
  String sPic;
// 构造函数
  ProductItemModel(
      {this.sId,
      this.title,
      this.cid,
      this.price,
      this.oldPrice,
      this.pic,
      this.sPic});

//  命名构造函数 接收传过来的 Map 数据，把他赋值给当前类的属性
  ProductItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    cid = json['cid'];
    price = json['price'];
    oldPrice = json['old_price'];
    pic = json['pic'];
    sPic = json['s_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['cid'] = this.cid;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['pic'] = this.pic;
    data['s_pic'] = this.sPic;
    return data;
  }
}
