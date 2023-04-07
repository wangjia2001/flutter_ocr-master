import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

String perid;

class TemplatePage extends StatefulWidget {
  final String username;
  TemplatePage({Key key, @required this.username}) : super(key: key);

  //模板部分
  @override
  _TemplatePageState createState() {
    perid = username;
    return _TemplatePageState();
  }
}

class _TemplatePageState extends State<TemplatePage> {
  // @override
  // Widget build(BuildContext context) {
  //   return new Container(
  //     child: Text('模板'),
  //   );
  // }
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _ggController = new TextEditingController();
  TextEditingController _numController = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();
  var i = 0;
  // var list = List(15);
  var list = [];

  insert() async {
    print(list);
    // Open a connection (testdb should already exist)
    for (var i = 0; i < 5; i++) {
      MySqlConnection conn = await MySqlConnection.connect(ConnectionSettings(
          host: '123.57.186.243',
          port: 3306,
          user: 'root',
          password: '12345678',
          db: 'test'));

      //查询
      // var results =
      //     await conn.query('select id,goodsname,specification from goods');
      var mmax = -1;
      var findid = -1;
      //close the connection
      // await conn.close();
      print("dididid");
      print(list);
      var results =
          await conn.query('select id,goodsname,specification from goods');
      // print(results);
      // print("55");
      for (var item in results) {
        // if (int.parse(item[0]) > mmax) {
        if (item[0] > mmax) {
          // mmax = int.parse(item[0]);
          mmax = item[0];
        }
        if (list[i * 3].toString() == item[1] &&
            list[i * 3 + 1].toString() == item[2]) {
          // findid = int.parse(item[0]);
          findid = item[0];
          print("findid:");
          print(findid);
          // showText("欢迎登陆" + item[0]);
          // Navigator.push(context, MaterialPageRoute(builder: (context) {
          //   return HostPage(username: item[0]);
          // }));
          // break;
        }
      }
//把东西存起来
      if (findid != -1) //找到了
      {
        list.add(findid);
        list.add(0);
      } else //没找到
      {
        list.add(mmax + 1);
        list.add(1);
      }
      print(list);
      print(list[16 + 2 * i]);
      //insert goods
      if (list[16 + 2 * i] != 0) {
        print("insert");
        await conn.query(
            'insert into goods (id,goodsname,specification) values ( ?, ? , ?)',
            [
              // list[15 + 2 * i].toString(),
              list[15 + 2 * i],
              list[i * 3].toString(),
              list[i * 3 + 1].toString(),
            ]);
      }

      await conn.close();
    }

    MySqlConnection conn = await MySqlConnection.connect(ConnectionSettings(
        host: '123.57.186.243',
        port: 3306,
        user: 'root',
        password: '12345678',
        db: 'test'));

    // //放需求表
    var needresults = await conn.query('select id,goods1 from need');
    var needmax = -1;
    // var perid = 0;
    for (var item in needresults) {
      // if (int.parse(item[0]) > needmax) {
      //   needmax = int.parse(item[0]);
      if (int.parse(item[0]) > needmax) {
        needmax = int.parse(item[0]);
      }
    }
    await conn.query(
        'insert into need (id,goods1,goods2,goods3,goods4,goods5,number1,number2,number3,number4,number5,personid,yorn) values ( ?, ? , ? , ? , ? , ? , ? , ? , ? , ? , ?,?,?)',
        [
          (needmax + 1).toString(),
          list[15].toString(),
          list[17].toString(),
          list[19].toString(),
          list[21].toString(),
          list[23].toString(),
          list[2].toString(),
          list[5].toString(),
          list[8].toString(),
          list[11].toString(),
          list[14].toString(),
          perid,
          "no",
        ]);

    //放person表中
    var personresults = await conn
        .query('select perid,need1,need2,need3,need4,need5 from person');
    // print(personresults);
    var findid = -1;
    var findpla = -1;
    for (var item in personresults) {
      if (item[0] == perid) {
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
            listperson[j] = (needmax + 1).toString();
            break;
            // break;
          }
        }
        if (findpla == -1) {
          Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('每人最多有五个需求单哦'),
              duration: Duration(milliseconds: 2000)));
        } else {
          await conn.query(
              // 'update person set  ? = ? where id = ?', [temp, temp1, perid]);
              // 'update person set ? = ? where perid = ?',
              // [temp, temp1, perid]);
              'update person set need1=?,need2=?,need3=?,need4=?,need5 = ? where perid = ?',
              [
                listperson[1],
                listperson[2],
                listperson[3],
                listperson[4],
                listperson[5],
                listperson[0]
              ]);
        }
        // var temp1 = (needmax + 1).toString();
        // var temp = "need" + findpla.toString();
        // print(temp);
        // await conn.query(
        //     // 'update person set  ? = ? where id = ?', [temp, temp1, perid]);
        //     // 'update person set ? = ? where perid = ?',
        //     // [temp, temp1, perid]);
        //     'update person set need4 = ? where perid = ?',
        //     [temp1, perid]);
        // //   needmax = int.parse(item[0]);
        // if (int.parse(item[0]) > needmax) {
        //   needmax = int.parse(item[0]);
      }
    }

    //close the connection
    await conn.close();
    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   // return MyApp();
    // }));

    // for (var j = 0; j < 25; j++) {
    //   list[j] = '';
    // }
    list.clear();
    setState(() {});
    Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('表格已入库'), duration: Duration(milliseconds: 2000)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Test"),
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
                          TableCell(child: Text('物品名称')),
                          TableCell(child: Text('物品规格')),
                          TableCell(child: Text('物品数量')),
                        ]),
                    TableRow(
                        decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0)),
                            color: Color(0xFF9ed6fb)),
                        children: [
                          TableCell(
                              child: Text(
                            list.length > 0 ? list[0].toString() : " ",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          )),
                          TableCell(
                              child: Text(
                            list.length > 1 ? list[1].toString() : " ",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                            ),
                          )),
                          TableCell(
                              child: Text(
                            list.length > 2 ? list[2].toString() : " ",
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
                            list.length > 3 ? list[3].toString() : " ",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          )),
                          TableCell(
                              child: Text(
                            list.length > 4 ? list[4].toString() : " ",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                            ),
                          )),
                          TableCell(
                              child: Text(
                            list.length > 5 ? list[5].toString() : " ",
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
                            list.length > 6 ? list[6].toString() : " ",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          )),
                          TableCell(
                              child: Text(
                            list.length > 7 ? list[7].toString() : " ",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                            ),
                          )),
                          TableCell(
                              child: Text(
                            list.length > 8 ? list[8].toString() : " ",
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
                            list.length > 9 ? list[9].toString() : " ",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          )),
                          TableCell(
                              child: Text(
                            list.length > 10 ? list[10].toString() : " ",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                            ),
                          )),
                          TableCell(
                              child: Text(
                            list.length > 11 ? list[11].toString() : " ",
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
                            list.length > 12 ? list[12].toString() : " ",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          )),
                          TableCell(
                              child: Text(
                            list.length > 13 ? list[13].toString() : " ",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                            ),
                          )),
                          TableCell(
                              child: Text(
                            list.length > 14 ? list[14].toString() : " ",
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
                TextFormField(
                    autofocus: true,
                    controller: _nameController,
                    decoration: InputDecoration(
                        labelText: "物品名称",
                        hintText: "如钢板",
                        icon: Icon(Icons.person)),
                    // 校验物品名称
                    validator: (v) {
                      return v.trim().length > 0 ? null : "物品名称不能为空";
                    }),
                TextFormField(
                    controller: _ggController,
                    decoration: InputDecoration(
                        labelText: "物品规格",
                        hintText: "如5m*5m",
                        icon: Icon(Icons.lock)),
                    // obscureText: true,
                    //校验物品规格
                    validator: (v) {
                      return v.trim().length > 0 ? null : "物品规格不能为空";
                    }),
                TextFormField(
                    autofocus: true,
                    controller: _numController,
                    decoration: InputDecoration(
                        labelText: "物品数量",
                        hintText: "如10",
                        icon: Icon(Icons.lock)),
                    // obscureText: true,
                    //校验物品数量
                    validator: (v) {
                      RegExp reg = new RegExp(r'^\d{1,10}$');
                      if (!reg.hasMatch(v)) {
                        return '数量必须是整数';
                      }
                      return null;
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
                      // 通过_formKey.currentState 获取FormState后，
                      // 调用validate()方法校验用户名密码是否合法，校验
                      // 通过后再提交数据。
                      if ((_formKey.currentState as FormState).validate()) {
                        print("submit");
                        print(
                            "物品名称:${_nameController.text}，物品规格:${_ggController.text}，物品数量:${_numController.text}");
                        if (i < 5) {
                          // print('$list'); // [null, null]
                          list.add(_nameController.text);
                          list.add(_ggController.text);
                          list.add(_numController.text);
                          i++;
                          _nameController.text = '';
                          _ggController.text = '';
                          _numController.text = '';
                        } else {
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text('非会员只能在表单中添加五个物品'),
                              duration: Duration(milliseconds: 2000)));
                        }
                        // print('$list2'); // [null, null]
                        setState(() {});
                        //验证通过提交数据
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
                      // 通过_formKey.currentState 获取FormState后，
                      // 调用validate()方法校验用户名密码是否合法，校验
                      // 通过后再提交数据。
                      // if ((_formKey.currentState as FormState).validate()) {
                      //   print("submit");
                      //   print(
                      //       "物品名称:${_nameController.text}，物品规格:${_ggController.text}，物品数量:${_numController.text}");
                      //   setState(() {});
                      //   //验证通过提交数据
                      // }
                      if (list.length > 1) {
                        while (list.length < 15) {
                          list.add(0);
                        }
                        print(list);
                        insert();
                      } else {
                        Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('表格不能为空'),
                            duration: Duration(milliseconds: 2000)));
                      }
                      // if()
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
