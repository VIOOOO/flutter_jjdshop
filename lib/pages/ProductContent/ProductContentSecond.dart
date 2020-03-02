import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';

// 商品详情-商品详情

class ProductContentSecond extends StatefulWidget {
  // 接收主页面传过来的商品数据
  final List _productContentList;
  ProductContentSecond(this._productContentList, {Key key}) : super(key: key);

  @override
  _ProductContentSecondState createState() => _ProductContentSecondState();
}

class _ProductContentSecondState extends State<ProductContentSecond> with AutomaticKeepAliveClientMixin{
  var _id;

  // 继承 AutomaticKeepAliveClientMixin 内保持页面状态
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    this._id = widget._productContentList[0].sId;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       child:Column(
        children: <Widget>[
           Expanded(
              child: InAppWebView(
                    initialUrl: "http://jd.itying.com/pcontent?id=${ this._id}",                   
                    onProgressChanged: (InAppWebViewController controller, int progress) {
                      
                    },
            ),
           )
        ],
      ),
    );
  }
}
