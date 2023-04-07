import 'package:flutter/material.dart';
import 'dbconnection.dart';
import 'package:dotted_border/dotted_border.dart';

class PersonalInformation extends StatefulWidget {
  final String username;
  PersonalInformation({Key key, @required this.username}) : super(key: key);

  @override
  _PersonalInformationState createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  String name = "null"; //姓名
  String email = "null"; //邮箱
  String company = "null";
  String tel = "null";
  String address = "null";

  @override
  void initState() {
    super.initState();
    // print("kaishi");
    updata();
  }

  //连接数据库
  updata() async {
    DbConnection db = new DbConnection();
    final conn = await db.getMysqlConnection();
    var results = await conn.query(
        'select email,name,tel,company,address from `account` where id = ? ',
        [widget.username]);
    await conn.close();
    for (var item in results) {
      setState(() {
        email = item[0].toString();
        name = item[1].toString();
        tel = item[2].toString();
        company = item[3].toString();
        address = item[4].toString();
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("用户信息", textAlign: TextAlign.center),
        ),
        body: Align(
            child: Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height / 7),
            // SizedBox(height: MediaQuery.of(context).size.height / 30),
            DottedBorder(
              color: Colors.black,
              borderType: BorderType.RRect,
              radius: Radius.circular(20),
              // gap: 3,
              strokeWidth: 2,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 15),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(50),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage("assets/images/1.jpg"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 5),
                          Image.asset(
                            "assets/images/info_name.png",
                            width: 35,
                            height: 35,
                          ),
                          Text('姓名：',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                          SizedBox(width: 5),
                          Text('$name',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                        ],
                      )),
                  SizedBox(height: 15),
                  Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 5),
                          Image.asset(
                            "assets/images/info_email.png",
                            width: 35,
                            height: 35,
                          ),
                          Text('邮箱：',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                          SizedBox(width: 10),
                          Text('$email',
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                        ],
                      )),
                  SizedBox(height: 15),
                  Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 5),
                          Image.asset(
                            "assets/images/info_school.png",
                            width: 35,
                            height: 35,
                          ),
                          Text('公司：',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                          SizedBox(width: 10),
                          Text('$company',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                        ],
                      )),
                  SizedBox(height: 15),
                  Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 5),
                          Image.asset(
                            "assets/images/info_major.png",
                            width: 35,
                            height: 35,
                          ),
                          Text('地址：',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                          SizedBox(width: 10),
                          Text('$address',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center),
                        ],
                      )),
                  SizedBox(height: 15),
                  Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 5),
                          Image.asset(
                            "assets/images/info_number.png",
                            width: 35,
                            height: 35,
                          ),
                          Text('电话：',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                          SizedBox(width: 10),
                          Text('$tel',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                        ],
                      )),
                  SizedBox(height: 15),
                  ButtonTheme(
                    minWidth: 50.0,
                    child: new RaisedButton(
                      //登出操作
                      color: Colors.black38,
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed("/login");
                      },
                      child: Container(
                        height: 40,
                        width: 80,
                        child:
                            Text('退出登录', style: TextStyle(color: Colors.white)),
                        alignment: Alignment.center,
                      ),
                      shape: StadiumBorder(
                        side: BorderSide(
                          width: 2,
                          color: Colors.black38,
                          style: BorderStyle.solid,
                          // style: BorderStyle.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )));
  }
}
