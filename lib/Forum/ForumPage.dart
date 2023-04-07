import 'package:flutter/material.dart';
import 'ListCard.dart';
import 'Model/CompanyModel.dart';
import 'DialoguePage.dart';
import 'SearchBar.dart';
import 'package:mysql1/mysql1.dart';

import 'NullListCard.dart';

class ForumPage extends StatefulWidget {
  //论坛部分
  @override
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  var preresult; //查询其中是否有数据
  var results; //用来查询存储查询结果
  var results1; //第二次查询结果
  Widget content; //单独一个widget组件，用于返回需要生成的内容widget
  Widget content1;
  Future<Widget> Lookup() async {
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
    preresult = await conn
        .query('select COUNT(*) from need where yorn="no"'); //查询数据库中的垩条数
    var count;
    print('数据库中的数据条数');
    for (var abc in preresult) {
      count = abc[0];
      print(count);
    }
    if (count == 0) {
      tiles.add(
        NullListCard(), //传值
      );
    } else {
      results = await conn.query(
          'select id,personid from need where yorn="no"'); //查询数据库中所有没有完成的需求单
      for (var item in results) {
        //将上面查询的结果
        var id = item[0];
        var personid = item[1];
        results1 = await conn.query(
            "select name,info,tel,address,email,company from account where id='$personid' ");
        for (var item1 in results1) {
          //从里面得到公司先关信息
          String id1 = id; //需求单id
          String personid1 = personid; //公司ID
          String name = item1['name']; //用户名称
          String info = item1['info']; //公司信息
          String tel = item1['tel']; //公司的电话
          String address = item1['address']; //公司的地址
          String email = item1['email']; //公司的邮箱
          String company = item1['company']; //公司名称
          CompanyModel company1 = CompanyModel(id1, personid1, name, info, tel,
              address, email, company); //进行封装方便后续使用
          tiles.add(
            ListCard(company1), //传值
          );
        }
      }
      ;
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

  @override
  void initState() {
    //初始化数据
    // TODO: implement initState
    Lookup();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  // //刷新数据
  // Future refresh() async {
  //   setState(() {
  //     future = Lookup();
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    Lookup();
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blue[200],
        title: SearchBar(),
        actions: <Widget>[
          InkWell(
            child: ButtonTheme(
              minWidth: 30,
              child: OutlineButton(
                borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1.0,
                    style: BorderStyle.solid), //设计边框为透明
                child: Text('搜索'),
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new Dialogue()));
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
