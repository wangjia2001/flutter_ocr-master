import 'package:flutter/material.dart';
import 'CompanyInfoPage.dart';
import 'DialoguePage.dart';
import 'Model/CompanyModel.dart';
import 'ViewDemandListPage.dart';

class ListCard extends StatefulWidget {
  final CompanyModel _company;
  ListCard(this._company);
  @override
  _ListCardState createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> {
  @override
  Widget build(BuildContext context) {
    //需要从ForumPage中得到数据
    CompanyModel company = widget._company;
    String id = company.id; //需求单id
    String personid = company.personid; //公司ID
    String name = company.name; //用户名称
    String info = company.info; //公司信息
    String tel = company.tel; //公司的电话
    String address = company.address; //公司的地址
    String email = company.email; //公司的邮箱
    String companyname = company.company; //公司名称

    Widget introduction = new Container(
      child: Row(
        children: <Widget>[
          new Container(
            height: 25.0,
            child: OutlineButton(
              borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1.0,
                  style: BorderStyle.solid), //设计边框为透明
              child: Text(
                "$companyname",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CompanyInfo(), //公司信息
                    settings: RouteSettings(
                      arguments: company, //传值
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );

    Widget Info = new Container(
      //公司介绍
      padding: const EdgeInsets.all(1.0),
      child: new Text("$info",
          style: TextStyle(
            fontSize: 17,
            fontStyle: FontStyle.italic,
          ),
          softWrap: true), //softWrap: true 文本是否在换行符处中断
    );

    Widget buttonSection = new Container(
      //两个bottom,必须在里面，因为需要跳转，不能放到外面
      child: new Row(
        //MainAxisAlignment.spaceEvenly平均分配子空间  他会在每个子项之间,之前,之后平均分配空闲空间 当然也可以使用Expanded来实现
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            //child 居中
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                iconSize: 30.0, //图片大小
                // padding: EdgeInsets.all(1.0), //图片边距
                icon: Icon(Icons.file_copy, color: Colors.blue[200]),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewDemandList(), //公司信息
                      settings: RouteSettings(
                        arguments: company, //传值
                      ),
                    ),
                  );
                },
              ),
              Text(
                "查看需求单",
                style: new TextStyle(
                  color: Colors.blue[200],
                ),
              ),
            ],
          ),
          SizedBox(width: 70), //两个组件距离
          Column(
            //child 居中
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                iconSize: 30.0, //图片大小
                // padding: EdgeInsets.all(1.0), //图片边距
                icon: Icon(Icons.forum, color: Colors.blue[200]),
                onPressed: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => new Dialogue()),
                  );
                },
              ),
              new Text(
                "回应",
                style: new TextStyle(
                  color: Colors.blue[200],
                ),
              ),
            ],
          ),
        ],
      ),
    );

    return Container(
      margin: EdgeInsets.only(left: 1, top: 3, right: 1, bottom: 5), //边距
      padding: EdgeInsets.only(left: 1, top: 18, right: 1, bottom: 4), //间距大小
      decoration: new BoxDecoration(
          //框颜色
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10.0)],
          color: Colors.white,
          borderRadius: BorderRadius.circular(18)),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 220),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(width: 2),
                  new Expanded(
                      child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      introduction,
                      SizedBox(height: 10),
                      Info,
                    ],
                  )),
                ],
              ),
            ),
            Divider(
              //分割线
              height: 3,
              thickness: 1.5, //线的宽度
              indent: 0, // 分割线左侧间距
              color: Colors.blue[200],
            ),
            buttonSection,
          ],
        ),
      ),
    );
  }
}
