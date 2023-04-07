import 'package:flutter/material.dart';
import 'SecondDialoguePage.dart';

import 'ComInfoComponent/Companyinfo.dart';
import 'ComInfoComponent/Personinfo.dart';
import 'Model/SecondCompanyModel.dart';

class CompanyInfo extends StatefulWidget {          //论坛部分
  @override
  _CompanyInfoState createState() => _CompanyInfoState();
}

class _CompanyInfoState extends State<CompanyInfo> {

  @override
  Widget build(BuildContext context) {
    SecondCompanyModel company= ModalRoute.of(context).settings.arguments; //接收数据
    return Scaffold(
      appBar: new AppBar(
        title: new Text('公司信息'),
        backgroundColor:Colors.blue[200],
        automaticallyImplyLeading: true,        //返回键
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 5),
          Company(company),
          SizedBox(height: 10),
          Person(company),
          SizedBox(height: 20),
          ButtonTheme(                  //用来设置宽度的，但不生效,原因位置
            minWidth: 50.0,
            child: new RaisedButton(         //设为合作操作
              color: Colors.lightBlueAccent,
              onPressed: () {
                print('成功设为合作伙伴');
              },
              child: Container(
                height: 40,
                width: 100,
                child: Text('设为合作伙伴', style: TextStyle(color: Colors.white)),
                alignment: Alignment.center,
              ),
              shape: StadiumBorder(
                side: BorderSide(
                  width: 2,
                  color: Colors.transparent,        //透明色
                  style: BorderStyle.solid,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          ButtonTheme(
            minWidth: 50.0,
            child: new RaisedButton(         //挑转到对话页面
              color: Colors.pink,
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => new SecondDialogue()),
                );
              },
              child: Container(
                height: 40,
                width: 40,
                child: Text('对话', style: TextStyle(color: Colors.white)),
                alignment: Alignment.center,
              ),
              shape: StadiumBorder(      //边框
                side: BorderSide(
                  width: 2,
                  color: Colors.transparent,        //透明色
                  style: BorderStyle.solid,
                  // style: BorderStyle.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}