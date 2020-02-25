import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import '../../config/Config.dart';
import 'package:dio/dio.dart';
import '../../model/CateModel.dart';

// 分类页面
class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  int _selectIndex = 0;
  List _leftCateList = [];
  List _rightCateList = [];

  // 继承 AutomaticKeepAliveClientMixin 内保持页面状态
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getLeftCateData();
  }

  // 获取左侧数据
  _getLeftCateData() async {
    var api = '${Config.domain}api/pcate';
    var reslut = await Dio().get(api);
    // 集合类型的类对象，通过模型类序列化 json
    var leftCateList = CateModel.fromJson(reslut.data);
    setState(() {
      this._leftCateList = leftCateList.result;
    });
    // 左侧数据请求结束后 请求对应右侧数据
    _getRightCateData(leftCateList.result[0].sId);
  }

  // 获取右侧数据 根据左侧的菜单 ID 获取对应数据
  _getRightCateData(pid) async {
    var api = '${Config.domain}api/pcate?pid=${pid}';
    var reslut = await Dio().get(api);
    var rightCateList = CateModel.fromJson(reslut.data);
    setState(() {
      this._rightCateList = rightCateList.result;
    });
  }

  // 左侧 Widget
  Widget _leftCateWidget(leftWidth) {
    if (this._leftCateList.length > 0) {
      return Container(
        width: leftWidth,
        height: double.infinity,
        // color: Colors.red,
        child: ListView.builder(
          // 左侧菜单列表
          itemCount: this._leftCateList.length,
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                // 按钮组件 ，内部可以配置任意组件，配置点击事件，设置点中的状态
                InkWell(
                  onTap: () {
                    setState(() {
                      this._selectIndex = index;
                      this._getRightCateData(this._leftCateList[index].sId);
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      '${this._leftCateList[index].title}',
                      textAlign: TextAlign.center,
                    ),
                    height: ScreenAdaper.height(84),
                    padding: EdgeInsets.only(top: ScreenAdaper.height(24)),
                    color: this._selectIndex == index
                        ? Color.fromRGBO(240, 246, 246, 0.9)
                        : Colors.white,
                  ),
                ),
                // 横线 组件本身有默认高度16,超过所需
                Divider(height: 1),
              ],
            );
          },
        ),
      );
    } else {
      // 返回空的容器 避免出现没有数据时候错位
      return Container(
        width: leftWidth,
        height: double.infinity,
      );
    }
  }

  // 右侧 Widget
  Widget _rightCateWidget(rightItemWidth, rightItemHeight) {
    if (this._rightCateList.length > 0) {
      return Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.all(10),
          height: double.infinity,
          color: Color.fromRGBO(240, 246, 246, 0.9),
          child: GridView.builder(
              // 动态生成
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                // 一行数量
                crossAxisCount: 3,
                // 宽高比
                childAspectRatio: rightItemWidth / rightItemHeight,
                // 主轴间距
                crossAxisSpacing: 10,
                // 纵轴间距
                mainAxisSpacing: 10,
              ),
              itemCount: this._rightCateList.length,
              itemBuilder: (context, index) {
                // 图片处理
                String pic = this._rightCateList[index].pic;
                pic = Config.domain + pic.replaceAll('\\', '/');

                // 返回每一个元素
                return InkWell(
                  onTap: (){
                    // 点击元素跳转 传递ID
                    Navigator.pushNamed(context, '/prouctListPage',arguments: {
                      "cid":this._rightCateList[index].sId
                    });
                  },
                  child: Container(
                  child: Column(
                    children: <Widget>[
                      // 配置图片宽高比
                      AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Image.network("${pic}", fit: BoxFit.cover),
                      ),
                      // 文本 控制高度
                      Container(
                        height: ScreenAdaper.height(28),
                        child: Text("${this._rightCateList[index].title}"),
                      )
                    ],
                  ),
                ),
                );
              }),
        ),
      );
    } else {
      // 返回空的容器 避免出现没有数据时候错位
      return Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.all(10),
          height: double.infinity,
          color: Color.fromRGBO(240, 246, 246, 0.9),
          child: Text("加载中..."),
        ),
      );
    }
  }

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
        _leftCateWidget(leftWidth),
        _rightCateWidget(rightItemWidth, rightItemHeight)
      ],
    );
  }
}
