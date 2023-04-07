import 'package:flutter/material.dart';

import 'Model/SecondCompanyModel.dart';
import 'SupplyInfo/TableData.dart';
import 'package:mysql1/mysql1.dart';

class SecondViewSupply extends StatefulWidget {
  //查看查看供给单功能
  @override
  _SecondViewSupplyState createState() => _SecondViewSupplyState();
}

class _SecondViewSupplyState extends State<SecondViewSupply> {
  @override
  Widget build(BuildContext context) {
    SecondCompanyModel company =
        ModalRoute.of(context).settings.arguments; //接收数据
    return Scaffold(
      appBar: new AppBar(
        title: Text('查看供给单'),
        automaticallyImplyLeading: true,
      ),
      body: new ListView(
        children: <Widget>[
          Text(
            '项目信息',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 2,
          ), //设置自高度
          TableData(company),
        ],
      ),
    );
  }
}
