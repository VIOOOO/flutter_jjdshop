import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';

// 分类页面
class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int _selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    // 屏幕适配 ScreenAdaper 需要在 build 里面初始化后才能使用
    ScreenAdaper.init(context);

    // 计算右侧 GridView 宽高比
    // 左侧栏宽度
    var leftWidth = ScreenAdaper.getScreenWidth() / 4;

    //右侧每一项宽度=（总宽度-左侧宽度-GridView外侧元素左右的Padding值-GridView中间的间距）/3
    var rightItemWidth =
        (ScreenAdaper.getScreenWidth() - leftWidth - 20 - 20) / 3;
    // 每一项宽度是按照比例显示在不同设备上
    rightItemWidth = ScreenAdaper.width(rightItemWidth);

    // 右侧每一项高度
    var rightItemHeight = rightItemWidth + ScreenAdaper.height(28);
    
    return Row(
      children: <Widget>[
        // 分两边，左侧固定宽度 右侧自适应
        Container(
          width: leftWidth,
          height: double.infinity,
          // color: Colors.red,
          child: ListView.builder(
            // 左侧菜单列表
            itemCount: 28,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  // 按钮组件 ，内部可以配置任意组件，配置点击事件，设置点中的状态
                  InkWell(
                    onTap: () {
                      setState(() {
                        this._selectIndex = index;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      child: Text(
                        '第${index}',
                        textAlign: TextAlign.center,
                      ),
                      height: ScreenAdaper.height(46),
                      color: this._selectIndex == index
                          ? Colors.red
                          : Colors.white,
                    ),
                  ),
                  Divider(),
                ],
              );
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.all(10),
            height: double.infinity,
            color: Color.fromRGBO(240, 246, 246, 0.9),
            child: GridView.builder(
                // 动态生成
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  // 数量
                  crossAxisCount: 3,
                  // 宽高比
                  childAspectRatio: rightItemWidth / rightItemHeight,
                  // 主轴间距
                  crossAxisSpacing: 10,
                  // 纵轴间距
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  // 返回每一个元素
                  return Container(
                    child: Column(
                      children: <Widget>[
                        // 配置图片宽高比
                        AspectRatio(
                          aspectRatio: 1 / 1,
                          child: Image.network(
                              'https://www.itying.com/images/flutter/list8.jpg'),
                        ),
                        // 文本 控制高度
                        Container(
                          height: ScreenAdaper.height(28),
                          child: Text("女装"),
                        )
                      ],
                    ),
                  );
                }),
          ),
        )
      ],
    );
  }
}
