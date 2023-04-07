import 'package:flutter/material.dart';
import 'package:flutter_ocr/Project/ProjectPage.dart';

import 'Model/SecondCompanyModel.dart';
import 'SupplyInfo/TableData.dart';
import 'package:mysql1/mysql1.dart';
import 'package:flutter_ocr/HomePage.dart';

class ViewSupply extends StatefulWidget {
  //查看查看供给单功能
  @override
  _ViewSupplyState createState() => _ViewSupplyState();
}

class _ViewSupplyState extends State<ViewSupply> {
  int flag; //做一个标志，用来判断是否更改
  Future<Widget> modify(SecondCompanyModel company) async {
    //确认改公司为供货公司时
    var results; //用来查询存储查询结果
    String personid = company.personid; //需要这家公司的id以及需求单
    String needid = company.needid;
    MySqlConnection conn = await MySqlConnection.connect(//连接数据库
        ConnectionSettings(
            host: '123.57.186.243',
            port: 3306,
            user: 'root',
            password: '12345678',
            db: 'test'));
    String yorn = 'yes';
    results = await conn.query(
        "update need set yorn='$yorn',person='$personid' where id='$needid' "); //修改数据库中yorn的数据为yes,并加入数personid

    await conn.close();
  }

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
          SizedBox(
            height: 30,
          ), //设置自高度
          ButtonTheme(
            minWidth: 50.0,
            child: new RaisedButton(
              //挑转到供应单页面
              color: Colors.pink,
              onPressed: () {
                showDialog<Null>(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return new AlertDialog(
                      title: new Text(
                        '注意',
                        style: TextStyle(color: Colors.red, fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      content: new SingleChildScrollView(
                        child: new ListBody(
                          children: <Widget>[
                            new Text(
                              '是否选择该公司为供应公司，一旦选择将无法修改!',
                              style: TextStyle(fontSize: 17),
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        RaisedButton(
                          child: Text("确定"),
                          color: Colors.blue,
                          textColor: Colors.white,
                          onPressed: () {
                            modify(company); //点了就修改
                            print("修改成功!");
                            Navigator.pushAndRemoveUntil(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => HomePage(
                                          username: company.personid1,
                                        )),
                                (route) => route == null);
                          },
                        ),
                        SizedBox(
                          width: 60,
                        ),
                        RaisedButton(
                          child: Text("取消"),
                          color: Colors.blue,
                          textColor: Colors.white,
                          onPressed: () {
                            print("取消");
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                ).then((val) {
                  print(val);
                });
              },
              child: Container(
                height: 40,
                width: 100,
                child: Text('确定供货单', style: TextStyle(color: Colors.white)),
                alignment: Alignment.center,
              ),
              shape: StadiumBorder(
                //边框
                side: BorderSide(
                  width: 2,
                  color: Colors.transparent, //透明色
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
