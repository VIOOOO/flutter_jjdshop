import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../services/ScreenAdaper.dart';

// 首页
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 轮播组件
  Widget _swiperWidget() {
    // 预设轮播图，后期用接口数据代替
    List<Map> imgList = [
      {"url": "https://www.itying.com/images/flutter/slide01.jpg"},
      {"url": "https://www.itying.com/images/flutter/slide02.jpg"},
      {"url": "https://www.itying.com/images/flutter/slide03.jpg"},
    ];
    // 轮播图需要在外层包裹一个设置宽高的容器，或者宽高比例的容器，设置固定宽高容易出现变形
    return Container(
      child: AspectRatio(
        // 宽高比例，在不同设备都不会变形固定比例
        aspectRatio: 2 / 1,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return new Image.network(
              imgList[index]['url'],
              fit: BoxFit.fill,
            );
          },
          // 轮播个数
          itemCount: 3,
          pagination: new SwiperPagination(),
          // autoplay: true,
        ),
      ),
    );
  }

  // 公共楼层标题组件
  Widget _titleWidget(value) {
    return Container(
      height: ScreenAdaper.height(32),
      margin: EdgeInsets.only(left: ScreenAdaper.width(20)),
      padding: EdgeInsets.only(left: ScreenAdaper.width(20)),
      decoration: BoxDecoration(
        border: Border(
          // 左边竖线
          left: BorderSide(
            color: Colors.red,
            width: ScreenAdaper.width(10),
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

  //热门商品
  Widget _hotProductListWidget() {
    return Container(
      // 外部高度设置要大于内部子元素高度之和
      height: ScreenAdaper.height(234),
      // width: double.infinity,
      padding: EdgeInsets.all(ScreenAdaper.width(10)),
      child: ListView.builder(
        // 水平列表
        scrollDirection: Axis.horizontal,
        itemBuilder: (contxt, index) {
          return Column(
            children: <Widget>[
              Container(
                height: ScreenAdaper.height(140),
                width: ScreenAdaper.width(140),
                margin: EdgeInsets.only(right: ScreenAdaper.width(21)),
                child: Image.network(
                  'https://www.itying.com/images/flutter/hot${index + 1}.jpg',
                  // 'http://www.serebii.net/pokemongo/pokemon/00${index + 1}.png',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: ScreenAdaper.height(10)),
                height: ScreenAdaper.height(44),
                child: Text("第${index + 1}条"),
              )
            ],
          );
        },
        // 循环次数
        itemCount: 10,
      ),
    );
  }

  // 推荐商品
  _recProductListWidget() {
    // 单个容器宽度 获取设备屏幕宽度 减去边宽度
    // 为了方便计算各元素宽度没有使用屏幕适配，使用屏幕适配会更好
    // var itemWidth = (ScreenAdaper.width(ScreenAdaper.getScreenWidth()) - 30) / 2;
    var itemWidth = (ScreenAdaper.getScreenWidth() - 30) / 2;

    return Container(
      // padding: EdgeInsets.all(ScreenAdaper.width(5)),
      padding: EdgeInsets.all(5),
      width: itemWidth,
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(233, 233, 233, 0.9), width: 1),
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: AspectRatio(
              // 设置宽高比1:1 防止服务器返回的图片大小不一致，导致高度不同
              aspectRatio: 1 / 1,
              child: Image.network(
                "https://www.itying.com/images/flutter/list1.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenAdaper.height(20)),
            child: Text(
              "2050夏季新款气质高贵洋气阔太太有女人味中长款宽松大码1111111111111111111",
              maxLines: 2,
              // 溢出隐藏
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.black54),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenAdaper.height(20)),
            // 定位组件
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '￥222.0',
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '￥569.0',
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
  }

  @override
  Widget build(BuildContext context) {
    // 屏幕适配需要放在 build 方法内，才能获取到 context
    // 并传入设计稿的宽高
    // ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
    ScreenAdaper.init(context);
    return ListView(
      children: <Widget>[
        _swiperWidget(),
        SizedBox(height: ScreenAdaper.height(20)),
        _titleWidget("猜你喜欢"),
        SizedBox(height: ScreenAdaper.height(20)),
        _hotProductListWidget(),
        _titleWidget("热门推荐"),
        Container(
          padding: EdgeInsets.all(10),
          child: Wrap(
            // 竖直间距
            runSpacing: 10,
            // 水平间距
            spacing: 10,
            children: <Widget>[
              _recProductListWidget(),
              _recProductListWidget(),
              _recProductListWidget(),
              _recProductListWidget(),
              _recProductListWidget(),
              _recProductListWidget(),
              _recProductListWidget(),
            ],
          ),
        )
      ],
    );
  }
}
