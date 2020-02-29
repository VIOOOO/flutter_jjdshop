import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';
import '../../widget/JdButton.dart';
import '../../model/ProductContentModel.dart';
import '../../config/Config.dart';

// 商品详情-商品页面

class ProductContentFrist extends StatefulWidget {
  // 接收主页面传过来的商品数据
  final List _productContentList;
  // 商品数据为必选参数
  ProductContentFrist(this._productContentList, {Key key}) : super(key: key);

  @override
  _ProductContentFristState createState() => _ProductContentFristState();
}

class _ProductContentFristState extends State<ProductContentFrist> {
  ProductContentItem _productContent;

  // 二级菜单的数据
  List _attr = [];

  @override
  void initState() {
    super.initState();
    // 把上一层的对象数据，赋值给当前组件
    this._productContent = widget._productContentList[0];
    this._attr = this._productContent.attr;
    // print(this._attr);
    // [{"cate":"鞋面材料","list":["牛皮 "]},{"cate":"闭合方式","list":["系带"]},{"cate":"颜色","list":["红色","白色","黄色"]}]
  }

  // 封装选项卡菜单内的二级菜单
  List<Widget> _getAttrItemWidget(attrItem) {
    List<Widget> attrItemList = [];

    attrItem.list.forEach((item) {
      attrItemList.add(Container(
        margin: EdgeInsets.all(10),
        child: Chip(
          label: Text("${item}"),
          padding: EdgeInsets.all(10),
        ),
      ));
    });

    return attrItemList;
  }

  // 封装选项卡菜单内的选项 渲染 attr
  List<Widget> _getAttrWidget() {
    List<Widget> attrList = [];

    // 循环将 数据取出放入 attrList
    this._attr.forEach((attrItem) {
      attrList.add(Wrap(
        children: <Widget>[
          Container(
            width: ScreenAdapter.width(120),
            child: Padding(
              padding: EdgeInsets.only(top: ScreenAdapter.height(22)),
              child: Text(
                "${attrItem.cate}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            width: ScreenAdapter.width(590),
            child: Wrap(
              children: this._getAttrItemWidget(attrItem),
            ),
          )
        ],
      ));
    });

    return attrList;
  }

  // 底部弹出菜单
  _attrBottomSheet() {
    showModalBottomSheet(
      // 上下文的对象
      context: context,
      builder: (context) {
        // GestureDetector 手势事件，点击不会有水波纹
        return GestureDetector(
            onTap: () {
              // 解决 showModalBottomSheet 点击弹出窗内部时候 会关闭弹出窗
              return false;
            },
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(ScreenAdapter.width(20)),
                  child: ListView(
                    children: <Widget>[
                      Column(
                        children: _getAttrWidget(),
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  width: ScreenAdapter.width(750),
                  height: ScreenAdapter.height(76),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: JdButton(
                            color: Color.fromRGBO(253, 1, 0, 0.9),
                            text: "加入购物车",
                            cb: () {
                              print("加入购物车");
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: JdButton(
                            color: Color.fromRGBO(225, 165, 0, 0.9),
                            text: "立即购买",
                            cb: () {
                              print("立即购买");
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // 图片处理
    String pic = Config.domain + this._productContent.pic;
    pic = pic.replaceAll('\\', '/');
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          // 配置图片宽高比
          AspectRatio(
            aspectRatio: 16 / 12,
            child: Image.network(
              "${pic}",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "${this._productContent.title}",
              style: TextStyle(
                color: Colors.black87,
                fontSize: ScreenAdapter.size(36),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "${this._productContent.subTitle}",
              style: TextStyle(
                color: Colors.black54,
                fontSize: ScreenAdapter.size(28),
              ),
            ),
          ),
          //价格
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Row(
                    children: <Widget>[
                      Text("特价: "),
                      Text(
                        "¥${this._productContent.price}",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: ScreenAdapter.size(46),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    // 水平轴 主轴设置
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text("原价: "),
                      Text(
                        "¥${this._productContent.oldPrice}",
                        style: TextStyle(
                            color: Colors.black38,
                            fontSize: ScreenAdapter.size(28),
                            decoration: TextDecoration.lineThrough),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          //筛选
          Container(
              margin: EdgeInsets.only(top: 10),
              height: ScreenAdapter.height(80),
              child: InkWell(
                onTap: () {
                  // 底部弹出菜单
                  _attrBottomSheet();
                },
                child: Row(
                  children: <Widget>[
                    Text("已选: ", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("115，黑色，XL，1件")
                  ],
                ),
              )),
          Divider(),
          Container(
            height: ScreenAdapter.height(80),
            child: Row(
              children: <Widget>[
                Text("运费: ", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("免运费")
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
