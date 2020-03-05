import 'package:event_bus/event_bus.dart';

// Bus 初始化
EventBus eventBus = EventBus();

//商品详情广播数据
class ProductContentEvent {
  String str;
  ProductContentEvent(String str) {
    this.str = str;
  }
}

//用户中心广播
class UserEvent {
  String str;
  UserEvent(String str) {
    this.str = str;
  }
}

// 新增收货地址页面广播
class AddressEvent {
  String str;
  AddressEvent(String str) {
    this.str = str;
  }
}

//结算页面 修改默认地址
class CheckOutEvent{
  String str;
  CheckOutEvent(String str){
    this.str=str;
  }
}

// 多个类
// class ProductContentEvent2 {
//   String str;

//   ProductContentEvent2(String str) {
//     this.str = str;
//   }
// }
