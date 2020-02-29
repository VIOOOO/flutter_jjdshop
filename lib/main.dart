import 'package:flutter/material.dart';
import 'routes/Routes.dart';
// import 'pages/tabs/Tabs.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
