import 'package:flutter/material.dart';
import '../../model/ProductContentModel.dart';

// 商品详情-评价页面

class ProductContentThird extends StatefulWidget {
  // 接收主页面传过来的商品数据
  final List _productContentList;
  ProductContentThird(this._productContentList, {Key key}) : super(key: key);

  @override
  _ProductContentThirdState createState() => _ProductContentThirdState();
}

class _ProductContentThirdState extends State<ProductContentThird> {
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
      child: ListView.builder(
        itemCount: 30,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("第${index}条"),
          );
        },
      ),
    );
  }
}
