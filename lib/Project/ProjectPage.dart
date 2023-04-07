import 'package:flutter/material.dart';
import 'package:flutter_ocr/Login/login.dart';
import 'package:mysql1/mysql1.dart' as sql;
import 'StartClip.dart';
import 'needinfo.dart';
import 'StartClip2.dart' as copy;

import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:percent_indicator/percent_indicator.dart';

// //wait
// class _CircleProgressPainter extends CustomPainter {
//   final double progress;

//   _CircleProgressPainter(this.progress);

//   Paint _paint = Paint()
//     ..style = PaintingStyle.stroke
//     ..strokeWidth = 10
//     ..strokeCap = StrokeCap.round;

//   @override
//   void paint(Canvas canvas, Size size) {
//     double radius = min(size.width, size.height) / 2;

//     Gradient gradient = SweepGradient(
//       startAngle: -pi / 2,
//       endAngle: pi * 2 * progress,
//       colors: [
//         Color(0xFFD32D2F),
//         Color(0xFFEA4886),
//       ],
//     );
//     var rect = Rect.fromLTWH(0, 0, radius * 2, radius * 2);

//     _paint.shader = gradient.createShader(rect);

//     canvas.save();
//     canvas.translate(0.0, size.height);
//     canvas.rotate(-pi / 2);

//     canvas.drawArc(rect, 0, pi * 2 * progress, false, _paint);

//     canvas.restore();
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           width: 150,
//           height: 150,
//           child: TweenAnimationBuilder(
//             tween: Tween(begin: 0.0, end: 1.0),
//             duration: Duration(seconds: 3),
//             builder: (BuildContext context, double value, Widget child) {
//               return CustomPaint(
//                 painter: _CircleProgressPainter(value),
//                 child: Center(child: Text('${(value * 100).floor()}%')),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
// //wait

class ProjectPage extends StatefulWidget {
  final String username;
  ProjectPage({Key key, @required this.username}) : super(key: key);
  //项目
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

var perid;
var perlist = []; //个人的person表
var neednum = 0; //需求表总数
var givenum = 0; //供货表总数
var yorn = []; //需求表是否接受
var success = []; //供货表对应的需求表的接受人
var finish = 0; //需求表已完成的数量
var ing = 0; //需求表未完成的数量
var succ = 0; //供货表完成的数量
var succing = 0; //供货表暂未被接受
var fail = 0; //供货表未完成的数量
// final PetCardViewModel data = new PetCardViewModel();

class _ProjectPageState extends State<ProjectPage> {
  connect() async {
    neednum = 0;
    givenum = 0;
    finish = 0;
    ing = 0;
    succ = 0;
    fail = 0;
    succing = 0;
    perlist.clear();
    yorn.clear();
    success.clear();
    print("begin");
    print("username------------" + perid);
    sql.MySqlConnection conn = await sql.MySqlConnection.connect(
        sql.ConnectionSettings(
            host: '123.57.186.243',
            port: 3306,
            user: 'root',
            password: '12345678',
            db: 'test'));

    var results =
        await conn.query('select * from person where perid=?', [perid]);
    print(results);
    for (var item in results) {
      for (var i = 0; i < 11; i++) {
        perlist.add(item[i]);
      }
    }

    for (var i = 1; i <= 5; i++) {
      if (perlist[i] != "0") {
        neednum++;
        var thisresults =
            await conn.query('select * from need where id=?', [perlist[i]]);
        print(thisresults);
        for (var item in thisresults) {
          yorn.add(item[12]);
          if (item[12] == 'no') {
            ing++;
          } else {
            finish++;
          }
        }
      }
      if (perlist[5 + i] != "0") {
        givenum++;
        var give_needid;
        var giveid_needid = await conn
            .query('select * from give where giveid=?', [perlist[5 + i]]);
        for (var item in giveid_needid) {
          give_needid = item[2];
        }
        var person;
        var t;
        var needid_yorn =
            await conn.query('select * from need where id=?', [give_needid]);
        for (var item in needid_yorn) {
          print("item是:");
          print(item);
          person = item[13];
          t = item[12];
        }

        print("person是：");
        print(person);
        print("perid是：");
        print(perid);

        if (person == perid) {
          success.add("1"); //成功被接受
          succ++;
        } else if (t == "no") {
          success.add("0"); //进行中
          succing++;
        } else {
          success.add("-1"); //失败
          fail++;
        }

        print("666");
        print(person);
        print(give_needid);
      }
    }
    // print("perlist");
    // print(perlist);
    // print("yorn");
    // print(yorn);
    // print("need");
    // print(neednum);
    // print("give");
    // print(givenum);
    print("供货单情况");
    print(success);
    print("供货单成功");
    print(succ);
    print("供货单进行中");
    print(succing);
    print("供货单失败");
    print(fail);

    setState(() {});

    await conn.close();
  }

  Widget _buildCard() {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
      child: Card(
        child: Container(
          margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNumberTextWidget(neednum.toString(), '总数'),
              _buildNumberTextWidget(ing.toString(), '进行中'),
              _buildNumberTextWidget(finish.toString(), '已结束'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard2() {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
      child: Card(
        child: Container(
          margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNumberTextWidget(givenum.toString(), '总数'),
              _buildNumberTextWidget(succing.toString(), '进行中'),
              _buildNumberTextWidget((succ + fail).toString(), '已结束'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumberTextWidget(String number, String text) {
    // var foreColor = Global.profile.darkMode
    //     ? Colors.white54
    //     : Theme.of(context).primaryColor;
    return TextButton(
      child: Column(children: [
        Text(number, style: TextStyle(fontSize: 30, color: Colors.white)),
        Text(text, style: TextStyle(color: Colors.white)),
      ]),
      style: ButtonStyle(
          padding:
              MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 4))),
      onPressed: () => print("123"),
    );
  }

  Widget loop() {
    //循环做取数据库存储数据操作
    List<Widget> tiles = [];
    Widget content; //单独一个widget组件，用于返回需要生成的内容widget
    tiles.add(
      //最开始的
      new Container(
        padding: EdgeInsets.all(10.0),
      ),
    );
    tiles.add(
      Container(
        width: MediaQuery.of(context).size.width,
        height: 110,
        color: Colors.white,
        child: _buildCard(),
      ),
    );
    tiles.add(
      Container(
        width: MediaQuery.of(context).size.width,
        height: 20,
        color: Colors.blue[50],
      ),
    );
    tiles.add(
      Container(
        width: MediaQuery.of(context).size.width,
        height: 20,
        color: Colors.white,
        child: Text('这是进行中的订单', textAlign: TextAlign.left),
      ),
    );
    tiles.add(
      Container(
        width: MediaQuery.of(context).size.width,
        height: 10,
        color: Colors.blue[50],
      ),
    );
    for (int i = 1; i <= neednum; i++) {
      if (yorn[i - 1] == "no") {
        needinfo temp = needinfo(perid, i.toString(), perlist[i], yorn[i - 1]);
        setState(() {
          tiles.add(
            StartClip(temp),
          );
        });
      }
    }
    tiles.add(
      Container(
        width: MediaQuery.of(context).size.width,
        height: 20,
        color: Colors.blue[50],
      ),
    );
    tiles.add(
      Container(
        width: MediaQuery.of(context).size.width,
        height: 20,
        color: Colors.white,
        child: Text('这是已结束的订单', textAlign: TextAlign.left),
      ),
    );
    tiles.add(
      Container(
        width: MediaQuery.of(context).size.width,
        height: 10,
        color: Colors.blue[50],
      ),
    );
    for (int i = 1; i <= neednum; i++) {
      if (yorn[i - 1] != "no") {
        needinfo temp = needinfo(perid, i.toString(), perlist[i], yorn[i - 1]);
        setState(() {
          tiles.add(
            StartClip(temp),
          );
        });
      }
    }
    // //删
    // tiles.add(CircleProgressPainter(.3));
    // CircleProgressPainter te = CircleProgressPainter(.3);
    // tiles.add(te.build(context));
    // Progress p = Progress();
    // p.value

    // tiles.add(CircleProgressWidget(
    //     progress: Progress(
    //         backgroundColor: Colors.grey,
    //         value: 0.0,
    //         radius: 100,
    //         completeText: "完成",
    //         color: Color(0xff46bcf6),
    //         strokeWidth: 4)));

    // tiles.add(new CircularPercentIndicator(
    //   radius: 120.0,
    //   lineWidth: 13.0,
    //   animation: true,
    //   percent: 1.0,
    //   center: new Text(
    //     "70.0%",
    //     style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
    //   ),
    //   // footer: new Text(
    //   //   "Sales this week",
    //   //   style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
    //   // ),
    //   circularStrokeCap: CircularStrokeCap.round,
    //   progressColor: Colors.purple,
    // ));

    // tiles.add(Container(
    //   height: 150,
    //   width: 150,
    //   child: CustomPaint(
    //     painter: CircleProgressPainter(.3),
    //     child: Center(child: Text('30%')),
    //   ),
    // ));

//删
    content = new Column(children: tiles);
    return content;
  }

  Widget loop2() {
    //循环做取数据库存储数据操作
    List<Widget> tiles = [];
    Widget content; //单独一个widget组件，用于返回需要生成的内容widget
    tiles.add(
      //最开始的
      new Container(
        padding: EdgeInsets.all(10.0),
      ),
    );
    tiles.add(
      Container(
        width: MediaQuery.of(context).size.width,
        height: 110,
        color: Colors.white,
        child: _buildCard2(),
      ),
    );
    tiles.add(
      Container(
        width: MediaQuery.of(context).size.width,
        height: 20,
        color: Colors.blue[50],
      ),
    );
    tiles.add(
      Container(
        width: MediaQuery.of(context).size.width,
        height: 20,
        color: Colors.white,
        child: Text('这是进行中的订单', textAlign: TextAlign.left),
      ),
    );
    tiles.add(
      Container(
        width: MediaQuery.of(context).size.width,
        height: 10,
        color: Colors.blue[50],
      ),
    );
    for (int i = 1; i <= givenum; i++) {
      if (success[i - 1] == "0") {
        needinfo temp = needinfo(perid, i.toString(), perlist[5 + i], "no");
        setState(() {
          tiles.add(
            copy.StartClip(temp),
          );
        });
      }
    }
    tiles.add(
      Container(
        width: MediaQuery.of(context).size.width,
        height: 10,
        color: Colors.blue[50],
      ),
    );
    tiles.add(
      Container(
        width: MediaQuery.of(context).size.width,
        height: 20,
        color: Colors.white,
        child: Text('这是未被接受的订单', textAlign: TextAlign.left),
      ),
    );
    tiles.add(
      Container(
        width: MediaQuery.of(context).size.width,
        height: 10,
        color: Colors.blue[50],
      ),
    );
    for (int i = 1; i <= givenum; i++) {
      if (success[i - 1] == "-1") {
        needinfo temp = needinfo(perid, i.toString(), perlist[5 + i], "no");
        setState(() {
          tiles.add(
            copy.StartClip(temp),
          );
        });
      }
    }
    tiles.add(
      Container(
        width: MediaQuery.of(context).size.width,
        height: 10,
        color: Colors.blue[50],
      ),
    );
    tiles.add(
      Container(
        width: MediaQuery.of(context).size.width,
        height: 20,
        color: Colors.white,
        child: Text('这是被接受的订单', textAlign: TextAlign.left),
      ),
    );
    tiles.add(
      Container(
        width: MediaQuery.of(context).size.width,
        height: 10,
        color: Colors.blue[50],
      ),
    );
    for (int i = 1; i <= givenum; i++) {
      if (success[i - 1] == "1") {
        needinfo temp = needinfo(perid, i.toString(), perlist[5 + i], "no");
        setState(() {
          tiles.add(
            copy.StartClip(temp),
          );
        });
      }
    }
    content = new Column(children: tiles);
    return content;
  }

  @override
  Widget build(BuildContext context) {
    perid = widget.username;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          child: AppBar(
            bottom: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              tabs: <Widget>[
                Tab(
                  text: "我的需求单",
                ),
                Tab(
                  text: "我的供货单",
                )
              ],
            ),
          ),
          preferredSize: Size.fromHeight(50.0), //设置高度
        ),
        body: TabBarView(
          children: <Widget>[
            ListView(
              children: <Widget>[
                loop(),
                // ListTile(
                //   title: Text("tab2==1"),
                // ),
                // ListTile(
                //   title: Text("tab2==2"),
                // ),
                // ListTile(
                //   title: Text("tab2==3"),
                // )
              ],
            ),
            ListView(
              children: <Widget>[
                loop2(),
                // ListTile(
                //   title: Text("tab2==1"),
                // ),
                // ListTile(
                //   title: Text("tab2==2"),
                // ),
                // ListTile(
                //   title: Text("tab2==3"),
                // )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    //初始化数据
    // TODO: implement initState
    connect();
    super.initState();
  }
}

class PetCardViewModel {
  /// 封面地址
  // final String coverUrl;

  // /// 用户头像地址
  // final String userImgUrl;

  // /// 用户名
  // final String userName;

  // /// 用户描述
  // final String description;

  /// 话题
  final String topic;

  /// 发布时间
  final String publishTime;

  /// 发布内容
  final String publishContent;

  /// 回复数量
  final int replies;

  /// 喜欢数量
  final int likes;

  /// 分享数量
  final int shares;

  const PetCardViewModel({
    // this.coverUrl,
    // this.userImgUrl,
    // this.userName,
    // this.description,
    this.topic,
    this.publishTime,
    this.publishContent,
    this.replies,
    this.likes,
    this.shares,
  });
}
