import '../HomePage.dart';
import 'register.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mysql1/mysql1.dart' as mysql;

// ignore: non_constant_identifier_names
String Username;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() {
    return _LoginPageState();
  }
}

enum Action { Ok, Cancel }

class _LoginPageState extends State<LoginPage> {
  ///
  String _choice = 'Nothing';
  Future _openAlertDialog() async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false, //// user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('提示'),
          content: Text('账号或密码输入错误'),
          actions: <Widget>[
            // FlatButton(
            //   child: Text('取消'),
            //   onPressed: () {
            //     Navigator.pop(context, Action.Cancel);
            //   },
            // ),
            FlatButton(
              child: Text('确认'),
              onPressed: () {
                Navigator.pop(context, Action.Ok);
              },
            ),
          ],
        );
      },
    );

    switch (action) {
      case Action.Ok:
        setState(() {
          _choice = 'Ok';
        });
        break;
      // case Action.Cancel:
      //   setState(() {
      //     _choice = 'Cancel';
      //   });
      //   break;
      default:
    }
  }

  ///

  TextEditingController _pwdEditController;
  TextEditingController _userNameEditController;

  final FocusNode _userNameFocusNode = FocusNode();
  final FocusNode _pwdFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _pwdEditController = TextEditingController();
    _userNameEditController = TextEditingController();
    _pwdEditController.addListener(() => setState(() => {}));
    _userNameEditController.addListener(() => setState(() => {}));
  }

  @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: SingleChildScrollView(
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: <Widget>[
  //           _buildTopBannerWidget(),
  //           _buildAccountLoginTip(),
  //           _buildEditWidget(),
  //           _buildLoginRegisterButton(),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Column(children: [
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTopBannerWidget(),
            _buildAccountLoginTip(),
            _buildEditWidget(),
            _buildLoginRegisterButton(),
          ],
        ),
        // width: 400,
        // height: 700,
      ),
      Container(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(40, 10, 50, 0),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                        child: RichText(
                            text: TextSpan(
                                text: '我已经详细阅读并同意',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 13),
                                children: <TextSpan>[
                          TextSpan(
                              text: '《隐私政策》',
                              style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline)),
                          TextSpan(text: '和'),
                          TextSpan(
                              text: '《用户协议》',
                              style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline))
                        ])))
                  ])))
    ])));
  }

  ///

  ///

  void showText(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.purple,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  //连接数据库&查询
  Future getcheck() async {
    // Open a connection (testdb should already exist)
    final conn = await mysql.MySqlConnection.connect(mysql.ConnectionSettings(
        host: '123.57.186.243',
        port: 3306,
        user: 'root',
        password: '12345678',
        db: 'test'));
    //查询
    var results = await conn.query('select id,password from account');
    //close the connection
    await conn.close();
    var flag = 0;
    for (var item in results) {
      if (_userNameEditController.text.toString() == item[0] &&
          _pwdEditController.text.toString() == item[1]) {
        flag = 1;
        showText("欢迎登陆" + item[0]);
        Username = item[0];
        print("username---------" + Username);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HomePage(username: item[0]);
        }));
        break;
      }
    }
    if (flag == 0) {
      _openAlertDialog();
      // showText("账号或密码错误");
      // Scaffold.of(context).showSnackBar(SnackBar(
      //     content: Text('账号或密码错误'), duration: Duration(milliseconds: 2000)));

    }
  }

  _buildTopBannerWidget() {
    return Container(
        // child: Image.asset(
        //   "assets/images/login.jpg",
        //   fit: BoxFit.cover,
        // ),
        );
  }

  _buildAccountLoginTip() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Text(
        " ",
        maxLines: 1,
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: 16, color: Colors.black54),
      ),
    );
  }

  _buildLoginNameTextField() {
    return TextField(
      controller: _userNameEditController,
      focusNode: _userNameFocusNode,
      decoration: InputDecoration(
          hintText: "登录名/邮箱/手机",
          border: InputBorder.none,
          suffixIcon: (_userNameEditController.text ?? "").isEmpty
              ? IconButton(
                  icon: Image.asset(
                    "assets/images/login.jpg",
                    fit: BoxFit.cover,
                  ),
                  onPressed: () => {},
                )
              : IconButton(
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.purple,
                  ),
                  onPressed: () {
                    _userNameEditController.clear();
                    _userNameFocusNode.unfocus();
                    setState(() {});
                  })),
    );
  }

  _buildPwdTextField() {
    return TextField(
        controller: _pwdEditController,
        focusNode: _pwdFocusNode,
        obscureText: true,
        decoration: InputDecoration(
          hintText: "密码",
          border: InputBorder.none,
          suffixIcon: (_pwdEditController.text ?? "").isEmpty
              ? TextButton(
                  child: Text("忘记密码"),
                  onPressed: () {
                    _pwdFocusNode.unfocus();
                    _userNameFocusNode.unfocus();
                  })
              : IconButton(
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    _pwdEditController.clear();
                    _pwdFocusNode.unfocus();
                    setState(() {});
                  }),
        ));
  }

  _buildEditWidget() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
            width: 1.0 / MediaQuery.of(context).devicePixelRatio,
            color: Colors.grey.withOpacity(0.5)),
      ),
      child: Column(
        children: <Widget>[
          _buildLoginNameTextField(),
          Divider(height: 1.0),
          _buildPwdTextField(),
        ],
      ),
    );
  }

  _buildLoginRegisterButton() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: Colors.blue,
              ),
              child: TextButton(
                onPressed: () {
                  getcheck();
                },
                child: Text(
                  "登录",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(width: 15.0),
          Expanded(
              child: Container(
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(width: 1.0, color: Colors.green),
            ),
            child: TextButton(
                onPressed: () {
                  //导航到新路由
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return RegisterPage();
                  }));
                },
                child: Text(
                  "立即注册",
                  style: TextStyle(color: Colors.green),
                )),
          ))
        ],
      ),
    );
  }
}
