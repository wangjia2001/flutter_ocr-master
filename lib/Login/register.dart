import 'login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mysql1/mysql1.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _idController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _companyController = TextEditingController();
  TextEditingController _telController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _infoController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  final FocusNode _idFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _companyFocusNode = FocusNode();
  final FocusNode _telFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _infoFocusNode = FocusNode();
  final FocusNode _addressFocusNode = FocusNode();

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

  insert() async {
    // Open a connection (testdb should already exist)
    MySqlConnection conn = await MySqlConnection.connect(ConnectionSettings(
        host: '123.57.186.243',
        port: 3306,
        user: 'root',
        password: '12345678',
        db: 'test'));
    //insert
    await conn.query(
        'insert into account(id, password, company, tel, email, name, info, address) values(?, ?, ?, ?, ?, ?, ?, ?)',
        [
          _idController.text.toString(),
          _passwordController.text.toString(),
          _companyController.text.toString(),
          _telController.text.toString(),
          _emailController.text.toString(),
          _nameController.text.toString(),
          _infoController.text.toString(),
          _addressController.text.toString()
        ]);
    await conn.close();

    MySqlConnection connection = await MySqlConnection.connect(
        ConnectionSettings(
            host: '123.57.186.243',
            port: 3306,
            user: 'root',
            password: '12345678',
            db: 'test'));
    await connection.query(
        'insert into person( perid,  need1, need2, need3, need4, need5, give1, give2, give3, give4 ,give5) values ( ?, 0 , 0, 0, 0, 0, 0, 0, 0, 0, 0)',
        [
          _idController.text.toString(),
        ]);
    await connection.close();
    showText("注册成功！！！");
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LoginPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("注册"),
      ),
      body: new SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(10, 30, 10, 30),
              width: 100.0,
              height: 50.0,
              child: Center(
                child: Text(
                  '注册',
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 40.0,
                    height: 1.5,
                  ),
                ),
              ),
            ),
            // 间隔
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.fromLTRB(50, 10, 50, 10),
              width: 300.0,
              height: 40.0, //卡片大小
              child: new TextFormField(
                controller: _idController,
                focusNode: _idFocusNode,
                obscureText: false,
                // 装饰
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    hintText: '登陆账号',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
            SizedBox(height: 10), // 间隔
            Container(
              margin: EdgeInsets.fromLTRB(50, 10, 50, 10),
              width: 300.0,
              height: 40.0, //卡片大小
              child: new TextFormField(
                controller: _telController,
                focusNode: _telFocusNode,
                obscureText: false,
                // 装饰
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    hintText: '联系方式',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
            SizedBox(height: 10), // 间隔
            Container(
              margin: EdgeInsets.fromLTRB(50, 10, 50, 10),
              width: 300.0,
              height: 40.0, //卡片大小
              child: new TextFormField(
                controller: _companyController,
                focusNode: _companyFocusNode,
                obscureText: false,
                // 装饰
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    hintText: '所属公司',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
            SizedBox(height: 10), // 间隔
            Container(
              margin: EdgeInsets.fromLTRB(50, 10, 50, 10),
              width: 300.0,
              height: 40.0, //卡片大小
              child: new TextFormField(
                controller: _emailController,
                focusNode: _emailFocusNode,
                obscureText: false,
                // 装饰
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    hintText: '邮箱',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
            SizedBox(height: 10), // 间隔
            Container(
              margin: EdgeInsets.fromLTRB(50, 10, 50, 10),
              width: 300.0,
              height: 40.0, //卡片大小
              child: new TextFormField(
                controller: _nameController,
                focusNode: _nameFocusNode,
                obscureText: false,
                // 装饰
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    hintText: '昵称',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
            SizedBox(height: 10), // 间隔
            Container(
              margin: EdgeInsets.fromLTRB(50, 10, 50, 10),
              width: 300.0,
              height: 40.0, //卡片大小
              child: new TextFormField(
                controller: _infoController,
                focusNode: _infoFocusNode,
                obscureText: false,
                // 装饰
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    hintText: '个人简介',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
            SizedBox(height: 10), // 间隔
            Container(
              margin: EdgeInsets.fromLTRB(50, 10, 50, 10),
              width: 300.0,
              height: 40.0, //卡片大小
              child: new TextFormField(
                controller: _addressController,
                focusNode: _addressFocusNode,
                obscureText: false,
                // 装饰
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    hintText: '住址',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
            SizedBox(height: 10), // 间隔
            Container(
              margin: EdgeInsets.fromLTRB(50, 10, 50, 10),
              width: 300.0,
              height: 40.0, //卡片大小
              child: new TextFormField(
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                obscureText: false,
                // 装饰
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    hintText: '登陆密码',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
            SizedBox(height: 10), // 间隔
            Container(
                constraints:
                    BoxConstraints.tightFor(width: 250.0, height: 50.0), //卡片大小
                child: new MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    color: Colors.orange,
                    minWidth: double.infinity,
                    height: 40.0,
                    onPressed: () {
                      insert();
                    },
                    child: Text("Sign up"))),
          ],
        ),
      ),
    );
  }
}
