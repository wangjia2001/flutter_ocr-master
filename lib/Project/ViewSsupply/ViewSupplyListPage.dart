import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'Model/SecondCompanyModel.dart';
import 'SecondListCard.dart';
import 'Model/NeedAndPerson.dart'; //接受封装的数据
import 'FirstListCard.dart';
import '../jump.dart';
import 'SecondNullListCard.dart';
import 'package:flutter_ocr/HomePage.dart';
//  Navigator.pushAndRemoveUntil(
//                       context,
//                       new MaterialPageRoute(
//                           builder: (context) => new HomePage(
//                                 username: widget.username,
//                               )),
//                       (route) => route == null);

class ViewSupplyListPage extends StatefulWidget {
  //查看查看供给单功能
  final jump temp;
  @override
  _ViewSupplyListPageState createState() => _ViewSupplyListPageState();
  ViewSupplyListPage(this.temp);
}

class _ViewSupplyListPageState extends State<ViewSupplyListPage> {
  var preresult;
  var results; //用来查询存储查询结果
  var results1; //第二次查询结果
  var results2; //第三次结果
  Widget content; //单独一个widget组件，用于返回需要生成的内容widget
  Widget content1;
  Future<Widget> Lookup(String needid, String personid2) async {
    //数据库查询操作
    List<Widget> tiles = [];
    tiles.add(
      //最开始的
      new Container(
        padding: EdgeInsets.all(10.0),
      ),
    );
    // MySqlConnection conn;
    // print('配置数据库链接');
    // var s = ConnectionSettings(
    //     host: '123.57.186.243',
    //     port: 3306,
    //     user: 'root',
    //     password: '12345678',
    //     db: 'test'
    // );
    // //todo:获取数据库连接
    // await MySqlConnection.connect(s).then((_){
    //   conn=_;
    //   print('连接成功');
    // });
    MySqlConnection conn = await MySqlConnection.connect(ConnectionSettings(
        host: '123.57.186.243',
        port: 3306,
        user: 'root',
        password: '12345678',
        db: 'test'));
    preresult = await conn.query(
        "select COUNT(*) from give where needid='$needid' "); //查询数据库中的垩条数
    var count;
    print('数据库中的数据条数');
    for (var abc in preresult) {
      count = abc[0];
      print(count);
    }
    if (count == 0) {
      tiles.add(
        SecondNullListCard(), //传值
      );
    } else {
      results = await conn.query(
          "select giveid,personid,pri1,pri2,pri3,pri4,pri5 from give where needid='$needid' "); //查询数据库中所有的nedid相同的数据
      for (var item in results) {
        //将上面查询的结果
        String giveid = item[0];
        String personid = item[1];
        String pri1 = item[2]; //减少后面的一次查询工作
        String pri2 = item[3];
        String pri3 = item[4];
        String pri4 = item[5];
        String pri5 = item[6];
        results1 = await conn.query(
            "select name,info,tel,address,email,company from account where id='$personid' "); //查询各种数据
        for (var item1 in results1) {
          //从里面得到公司先关信息
          String personid1 = personid; //公司ID
          String name = item1['name']; //用户名称
          String info = item1['info']; //公司信息
          String tel = item1['tel']; //公司的电话
          String address = item1['address']; //公司的地址
          String email = item1['email']; //公司的邮箱
          String company = item1['company']; //公司名称
          SecondCompanyModel company1 = SecondCompanyModel(
              giveid,
              needid,
              personid1,
              personid2,
              name,
              info,
              tel,
              address,
              email,
              company,
              pri1,
              pri2,
              pri3,
              pri4,
              pri5); //进行封装方便后续使用
          tiles.add(
            SecondListCard(company1), //传值
          );
        }
      }
    }
    // 关闭数据库
    await conn.close();
    setState(() {});
    content = new Column(children: tiles);
    content1 = new ListView(
      children: [
        content,
      ],
    );
    return content1;
  }

  Future<Widget> Find(String needid, String personid2) async {
    //数据库查询操作
    List<Widget> tiles = [];
    tiles.add(
      //最开始的
      new Container(
        padding: EdgeInsets.all(10.0),
      ),
    );
    // MySqlConnection conn;
    // print('配置数据库链接');
    // var s = ConnectionSettings(
    //     host: '123.57.186.243',
    //     port: 3306,
    //     user: 'root',
    //     password: '12345678',
    //     db: 'test'
    // );
    // //todo:获取数据库连接
    // await MySqlConnection.connect(s).then((_){
    //   conn=_;
    //   print('连接成功');
    // });
    MySqlConnection conn = await MySqlConnection.connect(ConnectionSettings(
        host: '123.57.186.243',
        port: 3306,
        user: 'root',
        password: '12345678',
        db: 'test'));
    results = await conn
        .query("select person from need where id='$needid' "); //查找这个人的id
    for (var item in results) {
      //将上面查询的结果
      String personid = item[0]; //这个是供货单人的id
      results1 = await conn.query(
          "select giveid,pri1,pri2,pri3,pri4,pri5 from give where personid='$personid' and needid='$needid' "); //查询供货单id
      String giveid; //供货单id
      String pri1; //减少一次查询操作
      String pri2;
      String pri3;
      String pri4;
      String pri5;
      for (var item2 in results1) {
        giveid = item2[0]; //供货单id
        pri1 = item2[1]; //减少一次查询操作
        pri2 = item2[2];
        pri3 = item2[3];
        pri4 = item2[4];
        pri5 = item2[5];
      }
      results2 = await conn.query(
          "select name,info,tel,address,email,company from account where id='$personid' "); //查询各种数据
      for (var item1 in results2) {
        //从里面得到公司先关信息
        String personid1 = personid; //公司ID
        String name = item1['name']; //用户名称
        String info = item1['info']; //公司信息
        String tel = item1['tel']; //公司的电话
        String address = item1['address']; //公司的地址
        String email = item1['email']; //公司的邮箱
        String company = item1['company']; //公司名称
        SecondCompanyModel company1 = SecondCompanyModel(
            giveid,
            needid,
            personid1,
            personid2,
            name,
            info,
            tel,
            address,
            email,
            company,
            pri1,
            pri2,
            pri3,
            pri4,
            pri5); //进行封装方便后续使用
        tiles.add(
          FirstListCard(company1), //传值
        );
      }
    }
    ;
    setState(() {});
    content = new Column(children: tiles);
    content1 = new ListView(
      children: [
        content,
      ],
    );
    // 关闭数据库
    await conn.close();
    return content1;
  }

  // @override
  // void initState() {          //初始化数据
  //   // TODO: implement initState
  //   Lookup();
  //   super.initState();
  // }
  //
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    jump temp = widget.temp;
    NeedAndPerson needAndPerson =
        new NeedAndPerson(temp.id, temp.personid, temp.yorn);
    String needid = needAndPerson.Needid; //需求单
    String personid = needAndPerson.Personid; //数据传递
    String yorn = needAndPerson.yorn; //判断是否完成
    if (yorn == 'no') {
      //如果没有订货单
      Lookup(needid, personid); //传输数据
    } else {
      //存在订货单
      Find(needid, personid);
    }

    return Scaffold(
      appBar: new AppBar(
        title: Text('查看供给单'),
        actions: <Widget>[
          InkWell(
            child: ButtonTheme(
              minWidth: 30,
              child: OutlineButton(
                borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1.0,
                    style: BorderStyle.solid), //设计边框为透明
                child: Text(
                  '返回',
                  style: TextStyle(fontSize: 23),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => HomePage(
                                username: personid,
                              )),
                      (route) => route == null);
                },
              ),
            ),
            onTap: () {},
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: content1,
    );
  }
}
