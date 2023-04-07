import 'package:flutter/material.dart';
import '../Model/SecondCompanyModel.dart';

class Person extends StatefulWidget {
  final SecondCompanyModel companyModel;
  Person(this.companyModel);
  @override
  _PersonState createState() => _PersonState();
}

class _PersonState extends State<Person> {
  //个人信息板块
  Widget build(BuildContext context) {
    SecondCompanyModel company = widget.companyModel;
    String personid = company.personid; //公司ID
    String name = company.name; //用户名称
    String info = company.info; //公司信息
    String tel = company.tel; //公司的电话
    String address = company.address; //公司的地址
    String email = company.email; //公司的邮箱
    String companyname = company.company; //公司名称
    return Container(
      margin: EdgeInsets.only(left: 1, top: 3, right: 1, bottom: 5), //边距
      padding: EdgeInsets.only(left: 1, top: 18, right: 1, bottom: 4), //间距大小
      decoration: new BoxDecoration(
          //框颜色
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10.0)],
          color: Colors.white,
          borderRadius: BorderRadius.circular(18)),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Icon(
            Icons.person_outline_outlined,
            size: 80,
            color: Colors.blue[200],
          ), //图片部分
          SizedBox(width: 3),
          new Expanded(
            flex: 2,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  '$name',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '总监',
                  style: TextStyle(fontSize: 13),
                ),
                SizedBox(height: 2),
                ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: Colors.lightBlueAccent,
                  ),
                  title: Text('$tel'),
                ),
                ListTile(
                  leading: Icon(Icons.email, color: Colors.red),
                  title: Text('$email'),
                ),
                ListTile(
                  leading: Icon(Icons.room, color: Colors.lightBlueAccent),
                  title: Text('$address'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
