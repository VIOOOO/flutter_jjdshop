import 'package:flutter/material.dart';
import '../services/ScreenAdaper.dart';
import '../config/Config.dart';
import 'package:dio/dio.dart';
import '../model/ProductModel.dart';
import '../widget/LoadingWidget.dart';

// 商品列表
class ProuctListPage extends StatefulWidget {
  Map arguments;

  ProuctListPage({Key key, this.arguments}) : super(key: key);

  @override
  _ProuctListPageState createState() => _ProuctListPageState();
  // 在下面的 _ProuctListPageState 子类内获取 arguments 属性可以通过 widget.arguments 获取到
  // 子类内可以不再需要另外传入属性，并写构造函数接收
  // _ProuctListPageState createState() => _ProuctListPageState(arguments);
  // 因为_ProuctListPageState 子类 继承 State，又将ProuctListPage 泛型方式传入 ，所以子类内可以直接访问到 widget.arguments

}

class _ProuctListPageState extends State<ProuctListPage> {
  // 全局声明 GlobalKey 给组件命名，用于打开右侧抽屉组件
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  //用于上拉分页
  ScrollController _scrollController = ScrollController(); //listview 的控制器

  // 分页
  int _page = 1;

  // 页面一次请求的数据
  int _pageSize = 8;

  // 定义数据接收
  List _productList = [];

  // 排序 :价格升序 sort=price_1, 价格降序 sort=price_-1, 销量升序 sort=salecount_1, 销量降序 sort=salecount_-1
  String _sort = "";

  // 接口请求开关 解决滑动触发重复请求
  bool flag = true;

  // 是否以后数据
  bool _hasMore = true;

  @override
  void initState() {
    super.initState;
    this._getProductListData();

    //监听滚动条滚动事件
    _scrollController.addListener(() {
      // // 获取滚动条高度
      // _scrollController.position.pixels;
      // // 获取页面高度
      // _scrollController.position.maxScrollExtent;
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 20) {
        // 如果接口还在请求中 则不再请求
        if (this.flag && this._hasMore) {
          _getProductListData();
        }
      }
    });
  }

  // 获取商品列表的数据
  _getProductListData() async {
    // 避免上拉到底部时候触发重复的请求，所以添加开关
    setState(() {
      this.flag = false;
    });

    // 子类内获取路由传递的arguments  可以通过 widget.arguments 直接访问
    var api =
        '${Config.domain}api/plist?cid=${widget.arguments["cid"]}&page=${this._page}&sort=${this._sort}&pageSize=${this._pageSize}';
    print(api);
    var reslut = await Dio().get(api);
    var productList = ProductModel.fromJson(reslut.data);
    print(productList.result.length);

    if (productList.result.length < this._pageSize) {
      // 如果请求反回数据 ，每页数量小于指定一页的数量，则后面已经没有数据
      setState(() {
        // this._productList = productList.result;
        // 拼接后面查询到的数据
        this._productList.addAll(productList.result);
        this._hasMore = false;
        this.flag = true;
      });
    } else {
      setState(() {
        // this._productList = productList.result;
        // 拼接后面查询到的数据
        this._productList.addAll(productList.result);
        this._page++;
        this.flag = true;
      });
    }
  }

  //显示加载中的圈圈
  Widget _showMore(index) {
    if (this._hasMore) {
      return ((index == this._productList.length - 1) && !this.flag)
          ? LoadingWidget()
          : Text("");
    } else {
      return ((index == this._productList.length - 1) &&
              (index > this._pageSize))
          ? Text("--我是有底线的--")
          : Text("");
    }
  }

  // 商品列表
  Widget _productListWidget() {
    if (this._productList.length > 0) {
      return Container(
        padding: EdgeInsets.all(10),
        // 预留顶部位置给二级导航条，让页面滚动不会互相叠加
        margin: EdgeInsets.only(top: ScreenAdaper.height(80)),
        child: ListView.builder(
          // 监听滚动条滚动事件
          controller: _scrollController,
          itemBuilder: (context, index) {
            // 图片处理
            String pic = this._productList[index].pic;
            pic = Config.domain + pic.replaceAll("\\", "/");

            return Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: ScreenAdaper.width(180),
                      height: ScreenAdaper.height(180),
                      child: Image.network(
                        '${pic}',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: ScreenAdaper.height(180),
                        margin: EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "${this._productList[index].title}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  height: ScreenAdaper.height(36),
                                  margin: EdgeInsets.only(right: 10),
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),

                                  //注意 如果Container里面加上decoration属性，这个时候color属性必须得放在BoxDecoration
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromRGBO(230, 230, 230, 0.9),
                                  ),

                                  child: Text("4g"),
                                ),
                                Container(
                                  height: ScreenAdaper.height(36),
                                  margin: EdgeInsets.only(right: 10),
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromRGBO(230, 230, 230, 0.9),
                                  ),
                                  child: Text("126"),
                                ),
                              ],
                            ),
                            Text(
                              "￥${this._productList[index].price}",
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(height: 20),
                // 当索引值等于列表长度（滑动到底部），就显示 loading, 否则显示空文本
                _showMore(index),
              ],
            );
          },
          itemCount: this._productList.length,
        ),
      );
    } else {
      // 加载中
      return Container(
        // 预留顶部位置给二级导航条，让页面滚动不会互相叠加
        margin: EdgeInsets.only(top: ScreenAdaper.height(80)),
        width: double.infinity,
        child: !this.flag
            ? LoadingWidget()
            : Text("暂无数据", textAlign: TextAlign.center),
      );
    }
  }

// 自定义二级导航 筛选导航
  Widget _subHeaderWidget() {
    return Positioned(
      top: 0,
      height: ScreenAdaper.height(80),
      width: ScreenAdaper.width(750),
      child: Container(
        width: ScreenAdaper.width(750),
        height: ScreenAdaper.height(80),
        // color: Colors.red,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Color.fromRGBO(233, 233, 233, 0.9),
            ),
          ),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, ScreenAdaper.height(16), 0, ScreenAdaper.height(16)),
                  child: Text(
                    "综合",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
                onTap: () {},
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, ScreenAdaper.height(16), 0, ScreenAdaper.height(16)),
                  child: Text("销量", textAlign: TextAlign.center),
                ),
                onTap: () {},
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, ScreenAdaper.height(16), 0, ScreenAdaper.height(16)),
                  child: Text("价格", textAlign: TextAlign.center),
                ),
                onTap: () {},
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, ScreenAdaper.height(16), 0, ScreenAdaper.height(16)),
                  child: Text("筛选", textAlign: TextAlign.center),
                ),
                onTap: () {
                  // 打开右边侧边栏
                  _scaffoldKey.currentState.openEndDrawer();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Scaffold(
      // 给组件定义一个名字 ID
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('商品列表'),
        // // 将导航条内 左边的默认添加的图标替换掉
        // leading: Text(""),

        // 将导航条内 左边的默认添加的图标替换掉
        actions: <Widget>[Text("")],
      ),
      // 右侧抽屉组件
      endDrawer: Drawer(
        child: Container(
          child: Text("实现筛选功能"),
        ),
      ),
      // body: Text("${widget.arguments}"),
      body: Stack(
        // 定位组件
        children: <Widget>[
          // 页面内容
          _productListWidget(),
          // 顶部二级导航条 固定位置
          _subHeaderWidget()
        ],
      ),
    );
  }
}
