import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart' as MYSQL;
import 'StarPath.dart';
import 'needinfo.dart';

var list = [];
var all = [];
var number = 0;
var price = 0;

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
                      TableCell(child: Text('单价')),
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
                        all[2] == '0' ? " " : all[2],
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      )),
                      TableCell(
                          child: Text(
                        all[3] == '0' ? " " : all[3],
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
                        all[6] == '0' ? " " : all[6],
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      )),
                      TableCell(
                          child: Text(
                        all[7] == '0' ? " " : all[7],
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
                        all[10] == '0' ? " " : all[10],
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      )),
                      TableCell(
                          child: Text(
                        all[11] == '0' ? " " : all[11],
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
                        all[12] == '0' ? " " : all[12],
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      )),
                      TableCell(
                          child: Text(
                        all[13] == '0' ? " " : all[13],
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                        ),
                      )),
                      TableCell(
                          child: Text(
                        all[14] == '0' ? " " : all[14],
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      )),
                      TableCell(
                          child: Text(
                        all[15] == '0' ? " " : all[15],
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
                        all[16] == '0' ? " " : all[16],
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      )),
                      TableCell(
                          child: Text(
                        all[17] == '0' ? " " : all[17],
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                        ),
                      )),
                      TableCell(
                          child: Text(
                        all[18] == '0' ? " " : all[18],
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      )),
                      TableCell(
                          child: Text(
                        all[19] == '0' ? " " : all[19],
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
                        "合计",
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      )),
                      TableCell(
                          child: Text(
                        "",
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                        ),
                      )),
                      TableCell(
                          child: Text(
                        number.toString(),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      )),
                      TableCell(
                          child: Text(
                        price.toString(),
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
                  Navigator.pop(context, 'no');
                },
              ),
              RaisedButton(
                child: Text("确定"),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  print("确定");
                  Navigator.pop(context, "ok");
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
    needinfo temp = widget._temp;
    String thisid = temp.thisid;
    String id = temp.id;
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
          child: Text('这是您的第' + thisid + '个报价单 报价单id为' + id),
          onPressed: () async {
            list.clear();
            all.clear();
            number = 0;
            price = 0;
            MYSQL.MySqlConnection conn = await MYSQL.MySqlConnection.connect(
                MYSQL.ConnectionSettings(
                    host: '123.57.186.243',
                    port: 3306,
                    user: 'root',
                    password: '12345678',
                    db: 'test'));

            var results =
                await conn.query('select * from give where giveid=?', [id]);

            print(results);
            for (var item in results) {
              for (var i = 0; i < 8; i++) {
                list.add(item[i]);
              }
            }
            print(list);

            var sere =
                await conn.query('select * from need where id=?', [list[2]]);
            print(sere);
            for (var item in sere) {
              for (var j = 1; j <= 5; j++) {
                var thre = await conn
                    .query('select * from goods where id=?', [item[j]]);

                for (var item2 in thre) {
                  for (var k = 1; k <= 2; k++) {
                    all.add(item2[k]);
                  }
                }

                all.add(item[j + 5]);
                all.add(list[2 + j]);
              }
            }
            print(all);

            number = int.parse(all[2]) +
                int.parse(all[6]) +
                int.parse(all[10]) +
                int.parse(all[14]) +
                int.parse(all[18]);
            price = int.parse(all[2]) * int.parse(all[3]) +
                int.parse(all[6]) * int.parse(all[7]) +
                int.parse(all[10]) * int.parse(all[11]) +
                int.parse(all[14]) * int.parse(all[15]) +
                int.parse(all[18]) * int.parse(all[19]);
            print("number");
            print(number);
            print("price");
            print(price);
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
