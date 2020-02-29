import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';
import '../../widget/JdButton.dart';

// 商品详情-商品页面

class ProductContentFrist extends StatefulWidget {
  ProductContentFrist({Key key}) : super(key: key);

  @override
  _ProductContentFristState createState() => _ProductContentFristState();
}

class _ProductContentFristState extends State<ProductContentFrist> {
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
                        children: <Widget>[
                          // 颜色
                          Wrap(
                            children: <Widget>[
                              Container(
                                width: ScreenAdapter.width(100),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: ScreenAdapter.height(30)),
                                  child: Text(
                                    "颜色",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                width: ScreenAdapter.width(610),
                                child: Wrap(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      child: Chip(
                                        label: Text("白色"),
                                        padding: EdgeInsets.all(10),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      child: Chip(
                                        label: Text("白色"),
                                        padding: EdgeInsets.all(10),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      child: Chip(
                                        label: Text("白色"),
                                        padding: EdgeInsets.all(10),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),

                          // 风格
                          Wrap(
                            children: <Widget>[
                              Container(
                                width: ScreenAdapter.width(100),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: ScreenAdapter.height(30)),
                                  child: Text(
                                    "风格",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                width: ScreenAdapter.width(610),
                                child: Wrap(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      child: Chip(
                                        label: Text("白色"),
                                        padding: EdgeInsets.all(10),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      child: Chip(
                                        label: Text("白色"),
                                        padding: EdgeInsets.all(10),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      child: Chip(
                                        label: Text("白色"),
                                        padding: EdgeInsets.all(10),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      child: Chip(
                                        label: Text("白色"),
                                        padding: EdgeInsets.all(10),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      child: Chip(
                                        label: Text("白色"),
                                        padding: EdgeInsets.all(10),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      child: Chip(
                                        label: Text("白色"),
                                        padding: EdgeInsets.all(10),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),

                          // 尺寸
                          Wrap(
                            children: <Widget>[
                              Container(
                                width: ScreenAdapter.width(100),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: ScreenAdapter.height(30)),
                                  child: Text(
                                    "尺寸",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                width: ScreenAdapter.width(610),
                                child: Wrap(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      child: Chip(
                                        label: Text("白色"),
                                        padding: EdgeInsets.all(10),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      child: Chip(
                                        label: Text("白色"),
                                        padding: EdgeInsets.all(10),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      child: Chip(
                                        label: Text("白色"),
                                        padding: EdgeInsets.all(10),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
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
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          // 配置图片宽高比
          AspectRatio(
            aspectRatio: 16 / 9,
            child:
                Image.network("https://www.itying.com/images/flutter/p1.jpg"),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "联想ThinkPad 翼480（0VCD） 英特尔酷睿i5 14英寸轻薄窄边框笔记本电脑",
              style: TextStyle(
                color: Colors.black87,
                fontSize: ScreenAdapter.size(36),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "震撼首发，15.9毫米全金属外观，4.9毫米轻薄窄边框，指纹电源按钮，杜比音效，2G独显，预装正版office软件",
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
                        "¥28",
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
                        "¥50",
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
