import 'package:flutter/material.dart';
import 'package:flutter_jjdshop/routes/Routes.dart';
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
      // 初始化路由
      initialRoute: '/',
      onGenerateRoute: onGenerateRoute,
    );
  }
}
