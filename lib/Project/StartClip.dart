import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart' as MYSQL;
import 'StarPath.dart';
import 'jump.dart';
import 'needinfo.dart';
import 'pass.dart';

var list = [];
var all = [];
var tpersoninfo = [];

// import 'package:mysql1/mysql1.dart';
class StartClip extends StatefulWidget {
  final needinfo _temp;
  StartClip(this._temp);
  @override
  State<StatefulWidget> createState() => _StartClipState();
}

class _StartClipState extends State<StartClip>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  Future _alertDialog() async {
    var result = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("订货单"),
            content: Table(
              children: [
                TableRow(
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                        color: Color(0xFF70a8cc)),
                    children: [
                      TableCell(child: Text('名称')),
                      TableCell(child: Text('规格')),
                      TableCell(child: Text('数量')),
                    ]),
                TableRow(
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                        color: Color(0xFF9ed6fb)),
                    children: [
                      TableCell(
                          child: Text(
                        all[0] == '0' ? " " : all[0],
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      )),
                      TableCell(
                          child: Text(
                        all[1] == '0' ? " " : all[1],
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                        ),
                      )),
                      TableCell(
                          child: Text(
                        list[6] == '0' ? '' : list[6],
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      )),
                    ]),
                TableRow(
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                        color: Color(0xFFc7e6fd)),
                    children: [
                      TableCell(
                          child: Text(
                        all[2] == '0' ? " " : all[2],
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      )),
                      TableCell(
                          child: Text(
                        all[3] == '0' ? " " : all[3],
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                        ),
                      )),
                      TableCell(
                          child: Text(
                        list[7] == '0' ? '' : list[7],
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      )),
                    ]),
                TableRow(
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                        color: Color(0xFF9ed6fb)),
                    children: [
                      TableCell(
                          child: Text(
                        all[4] == '0' ? " " : all[4],
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      )),
                      TableCell(
                          child: Text(
                        all[5] == '0' ? " " : all[5],
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                        ),
                      )),
                      TableCell(
                          child: Text(
                        list[8] == '0' ? '' : list[8],
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      )),
                    ]),
                TableRow(
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                        color: Color(0xFFc7e6fd)),
                    children: [
                      TableCell(
                          child: Text(
                        all[6] == '0' ? " " : all[6],
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      )),
                      TableCell(
                          child: Text(
                        all[7] == '0' ? " " : all[7],
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                        ),
                      )),
                      TableCell(
                          child: Text(
                        list[9] == '0' ? '' : list[9],
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      )),
                    ]),
                TableRow(
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                        color: Color(0xFF9ed6fb)),
                    children: [
                      TableCell(
                          child: Text(
                        all[8] == '0' ? " " : all[8],
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      )),
                      TableCell(
                          child: Text(
                        all[9] == '0' ? " " : all[9],
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                        ),
                      )),
                      TableCell(
                          child: Text(
                        list[10] == '0' ? '' : list[10],
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      )),
                    ]),

                // TableRow(children: [
                //   TableCell(child: Text(list[12])),
                //   TableCell(child: Text(list[13])),
                //   TableCell(child: Text(list[14])),
                // ]),
              ],
            ),
            actions: <Widget>[
              RaisedButton(
                child: Text("取消"),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  print("取消");
                  Navigator.pop(context, "no");
                },
              ),
              RaisedButton(
                child: Text("删除"),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  print("删除");
                  Navigator.pop(context, "delete");
                },
              ),
              RaisedButton(
                child: Text("详情"),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  print("personinfo");
                  print(tpersoninfo);

                  // tpersoninfo.add(personid);
                  // tpersoninfo.add(id);
                  // tpersoninfo.add(yorn);

                  print("详情");
                  jump temp =
                      jump(tpersoninfo[0], tpersoninfo[1], tpersoninfo[2]);

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => pass(temp),
                  //     // Pass the arguments as part of the RouteSettings. The
                  //     // ExtractArgumentScreen reads the arguments from these
                  //     // settings.
                  //     settings: RouteSettings(
                  //       arguments: temp,
                  //     ),
                  //   ),
                  // );

                  Navigator.push(
                    //跳转到第二个界面
                    context,
                    MaterialPageRoute(builder: (context) => pass(temp)),
                  );

                  // print("跳转");
                  // print("personid");
                  // print(personid);
                  // print("订单号");
                  // print(id);
                  // print("yorn");
                  // print(yorn);

                  //
                  //在这个地方跳转
                  //
                  // Navigator.pop(context, "jump");
                },
              ),
            ],
          );
        });
    print("result   -- >  " + result);
    return result;
  }

  @override
  void initState() {
    list.clear();
    _controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _controller.reverse();
            } else if (status == AnimationStatus.dismissed) {
              _controller.forward();
            }
          });
    _animation = Tween(begin: 1.0, end: 4.0).animate(_controller);
    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //编号
    String thisid;
//数据库中id
    String id;
//是否结束
    String yorn;
//personid
    String personid;

    needinfo temp = widget._temp;
    //需求单编号
    thisid = temp.thisid;
    //需求单真实id
    id = temp.id;
    //需求单是否完成
    yorn = temp.yorn;
    //personid
    personid = temp.personid;
    print("收到数据");
    print("personid");
    print(personid);
    print("订单号");
    print(id);
    print("yorn");
    print(yorn);
    print("收到数据结束");
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Center(
          child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return ClipPath(
                  clipper: StarPath(scale: _animation.value),
                  child: Container(
                    height: 50,
                    width: 50,
                    color: Colors.lightBlue[300],
                  ),
                );
              }),
        ),
        OutlineButton(
          child: Text('这是您的第' + thisid + '个需求单 需求单id为' + id),
          onPressed: () async {
            list.clear();
            all.clear();
            tpersoninfo.clear();
            print("放入数据");
            print("personid");
            print(personid);
            print("订单号");
            print(id);
            print("yorn");
            print(yorn);
            print("放入数据结束");

            tpersoninfo.add(personid);
            tpersoninfo.add(id);
            tpersoninfo.add(yorn);

            print("personinfo");
            print(tpersoninfo);

            MYSQL.MySqlConnection conn = await MYSQL.MySqlConnection.connect(
                MYSQL.ConnectionSettings(
                    host: '123.57.186.243',
                    port: 3306,
                    user: 'root',
                    password: '12345678',
                    db: 'test'));

            var results =
                await conn.query('select * from need where id=?', [id]);

            print(results);
            for (var item in results) {
              for (var i = 0; i < 13; i++) {
                list.add(item[i]);
              }
            }
            print("list:");
            print(list);

            for (var i = 1; i <= 5; i++) {
              var sere =
                  await conn.query('select * from goods where id=?', [list[i]]);
              print(sere);
              for (var item in sere) {
                for (var j = 1; j <= 2; j++) {
                  all.add(item[j]);
                }
              }
            }
            print("all");
            print(all);
            await conn.close();

            _alertDialog().then((value) {
              print(value);
            });
          },
        ),
        // Container(
        //   height: 50,
        //   width: 100,
        //   color: Colors.red,
        // ),
        // Container(
        //   height: 50,
        //   width: 100,
        //   color: Colors.green,
        // ),
        // Container(
        //   height: 50,
        //   width: 100,
        //   color: Colors.blue,
        // ),
      ],
    );
  }
}
