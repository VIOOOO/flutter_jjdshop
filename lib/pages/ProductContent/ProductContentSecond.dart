import 'package:flutter/material.dart';
import '../../model/ProductContentModel.dart';

// 商品详情-商品详情

class ProductContentSecond extends StatefulWidget {
  // 接收主页面传过来的商品数据
  final List _productContentList;
  ProductContentSecond(this._productContentList, {Key key}) : super(key: key);

  @override
  _ProductContentSecondState createState() => _ProductContentSecondState();
}

class _ProductContentSecondState extends State<ProductContentSecond> {
  ProductContentItem _productContent;

  @override
  void initState() {
    super.initState();
    // 把上一层的对象数据，赋值给当前组件
    this._productContent = widget._productContentList[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("商品详情"),
    );
  }
}
