import 'package:flutter/material.dart';
import '../../model/ProductContentModel.dart';

// 商品详情-评价页面

class ProductContentThird extends StatefulWidget {

  ProductContentThird({Key key}) : super(key: key);

  @override
  _ProductContentThirdState createState() => _ProductContentThirdState();
}

class _ProductContentThirdState extends State<ProductContentThird> {
  ProductContentItem _productContent;

  @override
  void initState() {
    super.initState();
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
