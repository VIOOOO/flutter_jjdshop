import 'package:flutter/material.dart';
import '../../services/CartServices.dart';
import '../../services/ScreenAdapter.dart';
import '../../widget/JdButton.dart';
import '../../model/ProductContentModel.dart';
import '../../config/Config.dart';
import '../ProductContent/CartNum.dart';
// 广播
import '../../services/EventBus.dart';
// 状态管理
import 'package:provider/provider.dart';
import '../../provider/Cart.dart';
// 弹出窗
import 'package:fluttertoast/fluttertoast.dart';

// 商品详情-商品页面
class ProductContentFrist extends StatefulWidget {
  // 接收主页面传过来的商品数据
  final List _productContentList;
  // 商品数据为必选参数
  ProductContentFrist(this._productContentList, {Key key}) : super(key: key);

  @override
  _ProductContentFristState createState() => _ProductContentFristState();
}

class _ProductContentFristState extends State<ProductContentFrist>
    with AutomaticKeepAliveClientMixin {
  ProductContentItem _productContent;

  // 二级菜单的数据
  List _attr = [];

  // 选中的商品项目
  String _selectedValue;

  // 继承 AutomaticKeepAliveClientMixin 内保持页面状态
  @override
  bool get wantKeepAlive => true;

  var actionEventBus;

  var cartProvider;

  @override
  void initState() {
    super.initState();
    // 把上一层的对象数据，赋值给当前组件
    this._productContent = widget._productContentList[0];
    this._attr = this._productContent.attr;
    // print(this._attr);
    // [{"cate":"鞋面材料","list":["牛皮 "]},{"cate":"闭合方式","list":["系带"]},{"cate":"颜色","list":["红色","白色","黄色"]}]
    _initAtter();

    // 监听广播 监听 ProductContentEvent 类的广播，若不写类 则是监听所有广播
    // eventBus.on().listen((event) {
    //   print(event);
    // });

    // 若事件监听广播 在离开页面时候不销毁，则每次进入页面会再创建监听事件
    this.actionEventBus = eventBus.on<ProductContentEvent>().listen((str) {
      print("广播事件：");
      print(str);
      // 监听到事件后弹出底部弹出框
      this._attrBottomSheet();
    });
  }

  //销毁 事件监听，不销毁监听 再次进入页面会发生错误，因为有的页面无值
  void dispose() {
    super.dispose();
    this.actionEventBus.cancel(); //取消事件监听
  }

  // 需要将数据内 list 转为如下的 Map 类型
  /*   
   [
     
      {
       "cate":"尺寸",
       list":[{

            "title":"xl",
            "checked":false
          },
          {

            "title":"xxxl",
            "checked":true
          },
        ]
      },
      {
       "cate":"颜色",
       list":[{

            "title":"黑色",
            "checked":false
          },
          {

            "title":"白色",
            "checked":true
          },
        ]
      }
  ]    
   */
  // 初始化 Attr 格式化数据 转换为 Map 类型
  _initAtter() {
    var attr = this._attr;
    // 循环取到商品的类型和选项
    for (var i = 0; i < attr.length; i++) {
      // 清空数组内的数据
      attr[i].attrList.clear();

      // 在对应的类型内 循环选项，修改用户的选中项目
      for (var j = 0; j < attr[i].list.length; j++) {
        // 将在数据模型里创建的 attrList 空数组 接收修改为 Map 类型的 list 数组，用于后面的记住用户选中
        if (j == 0) {
          // 默认每个类型第一项选中
          attr[i].attrList.add({"title": attr[i].list[j], "checked": true});
        } else {
          attr[i].attrList.add({"title": attr[i].list[j], "checked": false});
        }
      }
    }
    // 获取选中的值
    _getSelectedAttrValue();
  }

  // 改变属性值
  _changeAttr(cate, title, setBottomState) {
    var attr = this._attr;

    for (var i = 0; i < attr.length; i++) {
      if (attr[i].cate == cate) {
        // 选中类型内的项重置，再修改选中的项状态
        for (var j = 0; j < attr[i].attrList.length; j++) {
          attr[i].attrList[j]["checked"] = false;
          if (title == attr[i].attrList[j]["title"]) {
            attr[i].attrList[j]["checked"] = true;
          }
        }
      }
    }

    // 重新渲染, 但是弹出的菜单组件内数据与当前页的数据是分开的，没有同步刷新，所以需要用到 StatefulBuilder 需要传入的 setBottomState 刷新数据状态
    setBottomState(() {
      this._attr = attr;
    });
    // 获取选中的值
    _getSelectedAttrValue();
  }

  // 获取选中的值
  _getSelectedAttrValue() {
    var _list = this._attr;
    List tempArr = [];

    for (var i = 0; i < _list.length; i++) {
      for (var j = 0; j < _list[i].attrList.length; j++) {
        if (_list[i].attrList[j]['checked'] == true) {
          tempArr.add(_list[i].attrList[j]["title"]);
        }
      }
    }
    // print(tempArr.join(','));
    setState(() {
      this._selectedValue = tempArr.join(',');
      // 给筛选属性赋值 让商品选项的值赋值到数据模型 对象内创建的状态里
      this._productContent.selectedAttr = this._selectedValue;
    });
  }

  // 封装选项卡菜单内的二级菜单
  List<Widget> _getAttrItemWidget(attrItem, setBottomState) {
    List<Widget> attrItemList = [];

    attrItem.attrList.forEach((item) {
      attrItemList.add(Container(
        margin: EdgeInsets.all(10),
        child: InkWell(
          onTap: () {
            // 传入选中的，类型和数据状态
            _changeAttr(attrItem.cate, item["title"], setBottomState);
          },
          child: Chip(
            label: Text(
              "${item["title"]}",
              style: TextStyle(
                  color: item["checked"] ? Colors.white : Colors.black54),
            ),
            padding: EdgeInsets.all(10),
            backgroundColor: item["checked"] ? Colors.red : Colors.black26,
          ),
        ),
      ));
    });

    return attrItemList;
  }

  // 封装选项卡菜单内的选项 渲染 attr 传入弹出组件的数据状态
  List<Widget> _getAttrWidget(setBottomState) {
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
              // 传入弹出组件状态
              children: this._getAttrItemWidget(attrItem, setBottomState),
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
        // 因为弹窗组件和当前页数据是分开的，所以需要 StatefulBuilder  setBottomState 改变组件内的状态
        return StatefulBuilder(
          builder: (BuildContext context, setBottomState) {
            // GestureDetector 手势事件，点击不会有水波纹
            return GestureDetector(
                // 点击穿透等问题 可以配置behavior
                behavior: HitTestBehavior.opaque,
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
                            // 调用弹出组件，并传入数据状态
                            children: _getAttrWidget(setBottomState),
                          ),
                          Divider(),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            height: ScreenAdapter.height(80),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "数量: ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 10),
                                // 将商品出人 数量组件
                                CartNum(this._productContent),
                              ],
                            ),
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
                                cb: () async {
                                  // print("加入购物车");
                                  await CartServices.addCart(
                                      this._productContent);

                                  // 关闭底部筛选属性
                                  Navigator.of(context).pop();

                                  // 需要等待 购物车数据添加好后 调用Provider 更新数据
                                  this.cartProvider.updateCartList();
                                  // 提示弹出窗
                                  Fluttertoast.showToast(
                                    msg: '加入购物车成功',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                  );
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    this.cartProvider = Provider.of<Cart>(context);
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
          //筛选 若没有商品选项，则显示空字符串
          this._attr.length > 0
              ? Container(
                  margin: EdgeInsets.only(top: 10),
                  height: ScreenAdapter.height(80),
                  child: InkWell(
                    onTap: () {
                      // 底部弹出菜单
                      _attrBottomSheet();
                    },
                    child: Row(
                      children: <Widget>[
                        Text("已选: ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("${this._selectedValue}")
                      ],
                    ),
                  ),
                )
              : Text(""),
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
