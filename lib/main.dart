import 'package:flutter/material.dart';
import 'routes/Routes.dart';

// 引入状态管理库 和自己创建的状态文件
import 'package:provider/provider.dart';
import 'provider/Counter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // 状态 MultiProvider 组件需要放在根组件全局里监听变化，嵌套在 MyApp MaterialApp 外层，可以配置多个 providers
    return MultiProvider(
      // 当调用方法内的 notifyListeners 更新状态时候，通知其他组件，改变状态
       providers: [
         // 调用 ChangeNotifierProvider 方法 创建的类里面写 自己创建的状态类要一致
        ChangeNotifierProvider(create: (_) => Counter()),
      ],
      child: MaterialApp(
        // home: Tabs(),
        // 隐藏右上角 debug 标志
        debugShowCheckedModeBanner: false,
        // 初始化路由
        initialRoute: '/',
        onGenerateRoute: onGenerateRoute,

        // 主题颜色
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
      ),
    );
  }
}
