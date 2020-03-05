import 'package:flutter/material.dart';


// 编辑收货地址
class AddressEditPage extends StatefulWidget {
  AddressEditPage({Key key}) : super(key: key);

  @override
  _AddressEditPageState createState() => _AddressEditPageState();
}

class _AddressEditPageState extends State<AddressEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("编辑收货地址"),
      ),
      body: Center(
        child: Text("编辑收货地址"),
      ),
    );
  }
}
