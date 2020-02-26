import 'package:flutter_screenutil/flutter_screenutil.dart';

// 屏幕适配 需要在使用的页面，引入文件并在 build 内初始化
class ScreenAdapter {
  static init(context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
  }

  static height(double value) {
    // 获取计算后的高度，返回出去
    return ScreenUtil().setHeight(value);
  }

  static width(double value) {
    // 获取计算后的宽度，返回出去
    return ScreenUtil().setWidth(value);
  }

  // 获取设备高度
  static getScreenHeigh() {
    return ScreenUtil.screenHeightDp;
  }

  // 获取设备宽度
  static getScreenWidth() {
    return ScreenUtil.screenWidthDp;
  }

  // 字体大小
  static size(double size) {
    return ScreenUtil().setSp(size);
  }
}
