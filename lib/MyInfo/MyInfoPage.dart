// import 'package:flutter/material.dart';
// import 'package:flutter_ocr/Login/login.dart';

// import 'TitleSection.dart';
// import 'AboutUs.dart';
// import 'PersonalInformation.dart';
// import 'dbconnection.dart';
// import 'package:dotted_border/dotted_border.dart';

// class MyInfoPage extends StatefulWidget {
//   final String username;
//   MyInfoPage({Key key, @required this.username}) : super(key: key);

//   //我的部分
//   @override
//   _MyInfoPageState createState() => _MyInfoPageState();
// }

// class _MyInfoPageState extends State<MyInfoPage> {
//   // String id = "null";
//   String name = "null"; //学生姓名
//   String email = "null"; //学生的邮箱
//   String company = "null";
//   String tel = "null";
//   String address = "null";

//   @override
//   void initState() {
//     super.initState();
//     // print("kaishi");
//     updata();
//   }

//   //连接数据库
//   updata() async {
//     DbConnection db = new DbConnection();
//     final conn = await db.getMysqlConnection();
//     var results = await conn.query(
//       'select email,name,tel,company,address from `account` where id = username',
//     );
//     await conn.close();
//     for (var item in results) {
//       setState(() {
//         // id = item[0].toString();
//         email = item[0].toString();
//         name = item[1].toString();
//         tel = item[2].toString();
//         company = item[3].toString();
//         address = item[4].toString();
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         //避免后续的选择
//         children: <Widget>[
//           titleSection('$name'), //开头图片以及姓名部分
//           SizedBox(height: 10),
//           AboutUs(), //剩下的部分
//           PersonalInformation(),
//           SizedBox(height: 10),
//           ButtonTheme(
//             minWidth: 50.0,
//             child: new RaisedButton(
//               //登出操作
//               color: Colors.black38,
//               onPressed: () {
//                 Navigator.of(context).pushReplacementNamed("/login");
//               },
//               child: Container(
//                 height: 40,
//                 width: 80,
//                 child: Text('退出登录', style: TextStyle(color: Colors.white)),
//                 alignment: Alignment.center,
//               ),
//               shape: StadiumBorder(
//                 side: BorderSide(
//                   width: 2,
//                   color: Colors.black38,
//                   style: BorderStyle.solid,
//                   // style: BorderStyle.none,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
