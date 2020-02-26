import 'package:flutter/material.dart';
import '../../model/ProductModel.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../services/ScreenAdapter.dart';
import '../../config/Config.dart';
import 'package:dio/dio.dart';
// 轮播图类模型
import '../../model/FocusModel.dart';

// 首页
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  // 定义变量接收数据
  List _focusData = [];
  List _hotProductList = [];
  List _bestProductList = [];

// 继承 AutomaticKeepAliveClientMixin 内保持页面状态
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    this._getFocusData();
    this._getHotProductData();
    this._getBestProductData();
  }

  // 获取轮播图数据
  _getFocusData() async {
    // var api = 'http://jd.itying.com/api/focus';
    // 将写死的 api 地址修改为配置 内的
    var api = '${Config.domain}api/focus';

    var reslut = await Dio().get(api);
    // print(reslut.data is Map);
    // 集合类型的类对象，通过模型类序列化 json
    var focusList = FocusModel.fromJson(reslut.data);
    // // 循环变量
    // focusList.result.forEach((value) {
    //   print(value.title);
    //   print(value.pic);
    // });
    setState(() {
      this._focusData = focusList.result;
    });
  }

  // 获取猜你喜欢的数据
  _getHotProductData() async {
    var api = '${Config.domain}api/plist?is_hot=1';
    var result = await Dio().get(api);
    var hotProductList = ProductModel.fromJson(result.data);
    setState(() {
      this._hotProductList = hotProductList.result;
    });
  }

  // 获取热门推荐的数据
  _getBestProductData() async {
    var api = '${Config.domain}api/plist?is_best=1';
    var result = await Dio().get(api);
    var bestProductList = ProductModel.fromJson(result.data);
    setState(() {
      this._bestProductList = bestProductList.result;
    });
  }

  // 轮播组件
  Widget _swiperWidget() {
    // // 预设轮播图，后期用接口数据代替
    // List<Map> imgList = [
    //   {"url": "https://www.itying.com/images/flutter/slide01.jpg"},
    //   {"url": "https://www.itying.com/images/flutter/slide02.jpg"},
    //   {"url": "https://www.itying.com/images/flutter/slide03.jpg"},
    // ];

    if (this._focusData.length > 0) {
      // 轮播图需要在外层包裹一个设置宽高的容器，或者宽高比例的容器，设置固定宽高容易出现变形
      return Container(
        child: AspectRatio(
          // 宽高比例，在不同设备都不会变形固定比例
          aspectRatio: 2 / 1,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              String pic = this._focusData[index].pic;
              // 将写死的 api 地址修改为配置 内的
              pic = Config.domain + pic.replaceAll('\\', '/');
              return new Image.network(
                // imgList[index]['url'],
                // 因为 flutter 不会像浏览器自己处理斜线，所以需要转义符号，将链接内的 右斜线 换成 左斜线
                // "http://jd.itying.com/${pic.replaceAll('\\', '/')}",
                pic,
                fit: BoxFit.fill,
              );
            },
            // 轮播个数
            // itemCount: imgList.length,
            itemCount: this._focusData.length,
            pagination: new SwiperPagination(),
            // autoplay: true,
          ),
        ),
      );
    } else {
      // 无数据也要返回 Widget 组件
      return Text('加载中...');
    }
  }

  // 公共楼层标题组件
  Widget _titleWidget(value) {
    return Container(
      height: ScreenAdapter.height(32),
      margin: EdgeInsets.only(left: ScreenAdapter.width(20)),
      padding: EdgeInsets.only(left: ScreenAdapter.width(20)),
      decoration: BoxDecoration(
        border: Border(
          // 左边竖线
          left: BorderSide(
            color: Colors.red,
            width: ScreenAdapter.width(10),
          ),
        ),
      ),
      child: Text(
        value,
        style: TextStyle(
          // 黑灰色
          color: Colors.black54,
        ),
      ),
    );
  }

  //猜你喜欢
  Widget _hotProductListWidget() {
    if (this._hotProductList.length > 0) {
      return Container(
        // 外部高度设置要大于内部子元素高度之和
        height: ScreenAdapter.height(234),
        // width: double.infinity,
        padding: EdgeInsets.all(ScreenAdapter.width(10)),
        child: ListView.builder(
          // 水平列表
          scrollDirection: Axis.horizontal,
          itemBuilder: (contxt, index) {
            // 处理图片 将写死的 api 地址修改为配置 内的
            String sPic = this._hotProductList[index].sPic;
            // 第一个斜杠 '\' 是转义字符
            sPic = Config.domain + sPic.replaceAll('\\', '/');
            return Column(
              children: <Widget>[
                Container(
                  height: ScreenAdapter.height(140),
                  width: ScreenAdapter.width(140),
                  margin: EdgeInsets.only(right: ScreenAdapter.width(21)),
                  child: Image.network(
                    // 'https://www.itying.com/images/flutter/hot${index + 1}.jpg',
                    sPic,

                    // 'http://www.serebii.net/pokemongo/pokemon/00${index + 1}.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: ScreenAdapter.height(10)),
                  height: ScreenAdapter.height(44),
                  child: Text(
                    "￥${this._hotProductList[index].price}",
                    style: TextStyle(color: Colors.red),
                  ),
                )
              ],
            );
          },
          // 循环次数
          itemCount: this._hotProductList.length,
        ),
      );
    } else {
      return Text("");
    }
  }

  // 推荐商品
  _recProductListWidget() {
    // 单个容器宽度 获取设备屏幕宽度 减去边宽度
    // 为了方便计算各元素宽度没有使用屏幕适配，使用屏幕适配会更好
    // var itemWidth = (ScreenAdapter.width(ScreenAdapter.getScreenWidth()) - 30) / 2;
    var itemWidth = (ScreenAdapter.getScreenWidth() - 30) / 2;

    return Container(
      padding: EdgeInsets.all(10),
      child: Wrap(
        // 竖直间距
        runSpacing: 10,
        // 水平间距
        spacing: 10,
        children: this._bestProductList.map((value) {
          // 定义图片
          String sPic = value.sPic;
          sPic = Config.domain + sPic.replaceAll('\\', '/');
          return Container(
            // padding: EdgeInsets.all(ScreenAdapter.width(5)),
            padding: EdgeInsets.all(5),
            width: itemWidth,
            decoration: BoxDecoration(
              border: Border.all(
                  color: Color.fromRGBO(233, 233, 233, 0.9), width: 1),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  child: AspectRatio(
                    // 设置宽高比1:1 防止服务器返回的图片大小不一致，导致高度不同
                    aspectRatio: 1 / 1,
                    child: Image.network(
                      "${sPic}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: ScreenAdapter.height(20)),
                  child: Text(
                    "${value.title}",
                    maxLines: 2,
                    // 溢出隐藏
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: ScreenAdapter.height(20)),
                  // 定位组件
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '￥ "${value.price}"',
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '￥ "${value.oldPrice}"',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 屏幕适配需要放在 build 方法内，才能获取到 context
    // 并传入设计稿的宽高
    // ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
    ScreenAdapter.init(context);
    return ListView(
      children: <Widget>[
        _swiperWidget(),
        SizedBox(height: ScreenAdapter.height(20)),
        _titleWidget("猜你喜欢"),
        SizedBox(height: ScreenAdapter.height(20)),
        _hotProductListWidget(),
        _titleWidget("热门推荐"),
        _recProductListWidget(),
      ],
    );
  }
}
