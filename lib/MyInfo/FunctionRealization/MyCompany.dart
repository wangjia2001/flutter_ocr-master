import 'package:flutter/material.dart';

class MyCompany extends StatefulWidget {         //我的公司功能具体实现部分
  @override
  _MyCompanyState createState() => _MyCompanyState();
}

class _MyCompanyState extends State<MyCompany> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Text('我的公司'),
    );
  }
}