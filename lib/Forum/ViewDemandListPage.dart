import 'package:flutter/material.dart';
import 'package:flutter_ocr/Login/login.dart';
import 'SupplyList.dart';
import 'DemandComponent/TableData.dart';
import 'Model/CompanyModel.dart';

class ViewDemandList extends StatefulWidget {
  @override
  _ViewDemandListState createState() => _ViewDemandListState();
}

class _ViewDemandListState extends State<ViewDemandList> {
  //查看需求单界面
  Widget build(BuildContext context) {
    CompanyModel company = ModalRoute.of(context).settings.arguments; //接收数据
    return Scaffold(
      appBar: AppBar(
        //
        title: Text('预览'),
        automaticallyImplyLeading: true,
      ),
      body: ListView(
        //表格部分
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
          if (company.personid != Username)
            (ButtonTheme(
              minWidth: 50.0,
              child: new RaisedButton(
                //挑转到供应单页面
                color: Colors.blue,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new SupplyList()),
                      (route) => route == null);
                },
                child: Container(
                  height: 40,
                  width: 100,
                  child: Text('提供供应单', style: TextStyle(color: Colors.white)),
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
            ))
        ],
      ),
    );
  }
}
