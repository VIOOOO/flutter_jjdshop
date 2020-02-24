import 'package:flutter_screenutil/flutter_screenutil.dart';

// 屏幕适配
class ScreenAdaper {
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
}
