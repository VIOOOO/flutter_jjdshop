import 'package:event_bus/event_bus.dart';

// Bus 初始化
EventBus eventBus = EventBus();

// 新建类
class ProductContentEvent {
  String str;

  ProductContentEvent(String str) {
    this.str = str;
  }
}

// 多个类
// class ProductContentEvent2 {
//   String str;

//   ProductContentEvent2(String str) {
//     this.str = str;
//   }
// }