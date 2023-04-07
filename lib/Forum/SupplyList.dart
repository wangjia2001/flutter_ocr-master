import 'package:flutter/material.dart';
import 'package:flutter_ocr/HomePage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mysql1/mysql1.dart';
import 'package:flutter_ocr/Login/login.dart';
import 'DemandComponent/TableData.dart';

String personid = Username; //登录用户id
String needid = id; //需求单id
String need_personid = needperId; //需求单用户id
List pList = priorList;

class SupplyList extends StatefulWidget {
  @override
  _SupplyListState createState() {
    return _SupplyListState();
  }
}

class _SupplyListState extends State<SupplyList> {
  TextEditingController _priceController = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();
  var i = 0;
  var priceList = [];
  var totalPrice = [];

  insert() async {
    // Open a connection (testdb should already exist)
    MySqlConnection conn = await MySqlConnection.connect(ConnectionSettings(
        host: '123.57.186.243',
        port: 3306,
        user: 'root',
        password: '12345678',
        db: 'test'));

    //放give表
    var giveresults = await conn.query('select giveid,personid from give');
    var givemax = -1;
    for (var item in giveresults) {
      // if (int.parse(item[0]) > needmax) {
      //   needmax = int.parse(item[0]);
      if (int.parse(item[0]) > givemax) {
        givemax = int.parse(item[0]);
      }
    }
    // print((givemax + 1).toString());
    await conn.query(
        'insert into give (giveid,personid,needid,pri1,pri2,pri3,pri4,pri5) values ( ?, ? , ? , ? , ? , ? , ? , ? )',
        [
          (givemax + 1).toString(),
          personid,
          needid,
          priceList[0].toString(),
          priceList[1].toString(),
          priceList[2].toString(),
          priceList[3].toString(),
          priceList[4].toString(),
        ]);

    //放person表中
    var personresults = await conn
        .query('select perid,give1,give2,give3,give4,give5 from person');

    // var personresults = await conn.query('select * from person');

    print(personresults);
    var findid = -1;
    var findpla = -1;
    for (var item in personresults) {
      if (item[0] == personid) {
        findid = 1;
        var listperson = [];
        listperson.add(item[0]);
        listperson.add(item[1]);
        listperson.add(item[2]);
        listperson.add(item[3]);
        listperson.add(item[4]);
        listperson.add(item[5]);
        for (var j = 1; j <= 5; j++) {
          if (int.parse(item[j]) == 0) {
            findpla = j;
            listperson[j] = (givemax + 1).toString();
            break;
            // break;
          }
        }
        if (findpla == -1) {
          Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('每人最多有五个供货单哦'),
              duration: Duration(milliseconds: 2000)));
        } else {
          await conn.query(
              'update person set give1=?,give2=?,give3=?,give4=?,give5 = ? where perid = ?',
              [
                listperson[1],
                listperson[2],
                listperson[3],
                listperson[4],
                listperson[5],
                listperson[0]
              ]);
        }
      }
    }

    //close the connection
    await conn.close();
    // setState(() {});
    print("user:------------" + Username);
  }

  void showText(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.white,
        textColor: Colors.blue,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    // personid = Username;
    // needid = id;
    // need_personid = needperId;
    print("personid----------------------" + personid);
    print("needid----------------------" + needid);
    print("need_personid----------------------" + need_personid);

    // pList = priorList;
    print("priorList---------------------" + pList.toString());
    print("priceList----------------------" + priceList.toString());
    print("totalPrice----------------------" + totalPrice.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text("Submit Test"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          child: Form(
            key: _formKey, //设置globalKey，用于后面获取FormState
            autovalidate: true, //开启自动校验
            child: Column(
              children: <Widget>[
                Table(
                  children: [
                    TableRow(
                        decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0)),
                            color: Color(0xFF70a8cc)),
                        children: [
                          TableCell(child: Text('物品')),
                          TableCell(child: Text('规格')),
                          TableCell(child: Text('数量')),
                          TableCell(child: Text('单价')),
                          TableCell(child: Text('总价')),
                        ]),
                    TableRow(
                        decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0)),
                            color: Color(0xFF9ed6fb)),
                        children: [
                          TableCell(
                              child: Text(
                            pList.length > 0 ? pList[0].toString() : " ",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          )),
                          TableCell(
                              child: Text(
                            pList.length > 1 ? pList[1].toString() : " ",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                            ),
                          )),
                          TableCell(
                              child: Text(
                            pList.length > 2 ? pList[2].toString() : " ",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          )),
                          TableCell(
                              child: Text(
                            priceList.length > 0
                                ? priceList[0].toString()
                                : " ",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          )),
                          TableCell(
                              child: Text(
                            totalPrice.length > 0
                                ? totalPrice[0].toString()
                                : " ",
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
                            pList.length > 3 ? pList[3].toString() : " ",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          )),
                          TableCell(
                              child: Text(
                            pList.length > 4 ? pList[4].toString() : " ",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                            ),
                          )),
                          TableCell(
                              child: Text(
                            pList.length > 5 ? pList[5].toString() : " ",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          )),
                          TableCell(
                              child: Text(
                            priceList.length > 1
                                ? priceList[1].toString()
                                : " ",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          )),
                          TableCell(
                              child: Text(
                            totalPrice.length > 1
                                ? totalPrice[1].toString()
                                : " ",
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
                            pList.length > 6 ? pList[6].toString() : " ",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          )),
                          TableCell(
                              child: Text(
                            pList.length > 7 ? pList[7].toString() : " ",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                            ),
                          )),
                          TableCell(
                              child: Text(
                            pList.length > 8 ? pList[8].toString() : " ",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          )),
                          TableCell(
                              child: Text(
                            priceList.length > 2
                                ? priceList[2].toString()
                                : " ",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          )),
                          TableCell(
                              child: Text(
                            totalPrice.length > 2
                                ? totalPrice[2].toString()
                                : " ",
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
                            pList.length > 9 ? pList[9].toString() : " ",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          )),
                          TableCell(
                              child: Text(
                            pList.length > 10 ? pList[10].toString() : " ",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                            ),
                          )),
                          TableCell(
                              child: Text(
                            pList.length > 11 ? pList[11].toString() : " ",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          )),
                          TableCell(
                              child: Text(
                            priceList.length > 3
                                ? priceList[3].toString()
                                : " ",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          )),
                          TableCell(
                              child: Text(
                            totalPrice.length > 3
                                ? totalPrice[3].toString()
                                : " ",
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
                            pList.length > 12 ? pList[12].toString() : " ",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          )),
                          TableCell(
                              child: Text(
                            pList.length > 13 ? pList[13].toString() : " ",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                            ),
                          )),
                          TableCell(
                              child: Text(
                            pList.length > 14 ? pList[14].toString() : " ",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          )),
                          TableCell(
                              child: Text(
                            priceList.length > 4
                                ? priceList[4].toString()
                                : " ",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          )),
                          TableCell(
                              child: Text(
                            totalPrice.length > 4
                                ? totalPrice[4].toString()
                                : " ",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          )),
                        ]),
                  ],
                ),
                TextFormField(
                    autofocus: true,
                    controller: _priceController,
                    decoration: InputDecoration(
                        labelText: "物品价格",
                        hintText: "填入数字",
                        icon: Icon(Icons.person)),
                    // 校验物品名称
                    validator: (v) {
                      return v.trim().length > 0 ? null : "物品价格不能为空";
                    }),
                // 添加按钮
                Padding(
                  padding: const EdgeInsets.only(top: 28.0),
                  child: RaisedButton(
                    padding: EdgeInsets.all(15.0),
                    child: Text("添加"),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () {
                      if ((_formKey.currentState as FormState).validate()) {
                        print("submit");
                        print("物品价格:${_priceController.text}");
                        if (i < 5) {
                          priceList.add(_priceController.text);
                          print("priceList---------------" +
                              priceList.toString());
                          totalPrice.add(int.parse(priceList[i]) *
                              int.parse(pList[3 * i + 2]));
                          i++;
                          _priceController.text = '';
                          print(
                              "totalPrice------------" + totalPrice.toString());
                        } else {
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text('超出数量'),
                              duration: Duration(milliseconds: 2000)));
                        }
                        if (!mounted) {
                          return;
                        }
                        setState(() {});
                      }
                    },
                  ),
                ),
                // 提交按钮
                Padding(
                  padding: const EdgeInsets.only(top: 28.0),
                  child: RaisedButton(
                    padding: EdgeInsets.all(15.0),
                    child: Text("提交"),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () {
                      if (priceList.length > 1) {
                        // while (pList.length < 15) {
                        // var item = 0;
                        // pList.fillRange(priceList.length * 3 + 1, 15, 0);
                        // pList.add(0);

                        while (priceList.length < 5) {
                          priceList.add(0);
                        }
                        print(priceList);
                        // print(pList);
                        insert();
                      } else {
                        showText("提交成功");
                      }
                      // {
                      //   Scaffold.of(context).showSnackBar(SnackBar(
                      //       content: Text('请填写报价'),
                      //       duration: Duration(milliseconds: 2000)));
                      // }
                      Navigator.pushAndRemoveUntil(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new HomePage(
                                    username: personid,
                                  )),
                          (route) => route == null);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
