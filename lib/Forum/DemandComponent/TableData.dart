import 'package:flutter/material.dart';
import '../Model/CompanyModel.dart';
import 'TableStyle.dart';
import 'TableDetail.dart';
import 'package:mysql1/mysql1.dart';

List priorList;
String needperId;
String id;

class TableData extends StatefulWidget {
  final CompanyModel company;
  TableData(this.company);
  @override
  _TableDataState createState() => _TableDataState();
}

class _TableDataState extends State<TableData> {
  //表单数据获取
  var results; //用来查询存储查询结果
  var results1; //第二次查询结果
  var results2; //第三次查询结果
  var results3; //第四次查询结果
  var results4; //第五次查询结果
  var results5; //第六次查询结果
  var number1; //物品1的数量
  var number2; //物品2的数量
  var number3; //物品3的数量
  var number4; //物品4的数量
  var number5; //物品5的数量
  int total;
  var goodsname1; //物品1名字
  var goodsname2; //物品1名字
  var goodsname3; //物品1名字
  var goodsname4; //物品1名字
  var goodsname5; //物品1名字
  var specification1; //物品1名字
  var specification2; //物品1名字
  var specification3; //物品1名字
  var specification4; //物品1名字
  var specification5; //物品1名字
  Future<Widget> Lookup(String ID) async {
    //数据库查询操作
    var id = ID;
    MySqlConnection conn = await MySqlConnection.connect(//连接数据库
        ConnectionSettings(
            host: '123.57.186.243',
            port: 3306,
            user: 'root',
            password: '12345678',
            db: 'test'));
    results = await conn.query(
        'select goods1,goods2,goods3,goods4,goods5,number1,number2,number3,number4,number5 from need where id="$id"'); //查询数据库中所有没有完成的需求单
    for (var item in results) {
      //将上面查询的结果
      var goods1 = item[0];
      var goods2 = item[1];
      var goods3 = item[2];
      var goods4 = item[3];
      var goods5 = item[4];
      number1 = item[5];
      number2 = item[6];
      number3 = item[7];
      number4 = item[8];
      number5 = item[9];
      total = int.parse(item[5]) +
          int.parse(item[6]) +
          int.parse(item[7]) +
          int.parse(item[8]) +
          int.parse(item[9]);
      results1 = await conn.query(
          'select goodsname,specification from goods where id="$goods1"'); //第一件物品信息
      for (var item1 in results1) {
        goodsname1 = item1[0];
        specification1 = item1[1];
      }
      results2 = await conn.query(
          'select goodsname,specification from goods where id="$goods2"'); //第二件物品信息
      for (var item2 in results2) {
        goodsname2 = item2[0];
        specification2 = item2[1];
      }
      results3 = await conn.query(
          'select goodsname,specification from goods where id="$goods3"'); //第三件物品信息
      for (var item3 in results3) {
        goodsname3 = item3[0];
        specification3 = item3[1];
      }
      results4 = await conn.query(
          'select goodsname,specification from goods where id="$goods4"'); //第四件物品信息
      for (var item4 in results4) {
        goodsname4 = item4[0];
        specification4 = item4[1];
      }
      results5 = await conn.query(
          'select goodsname,specification from goods where id="$goods5"'); //第五件物品信息
      for (var item5 in results5) {
        goodsname5 = item5[0];
        specification5 = item5[1];
      }
    }
    ;
    if (goodsname1 == '0' || specification1 == '0') {
      goodsname1 = '';
      specification1 = '';
      number1 = '';
    }
    if (goodsname2 == '0' || specification2 == '0') {
      goodsname2 = '';
      specification2 = '';
      number2 = '';
    }
    if (goodsname3 == '0' || specification3 == '0') {
      goodsname3 = '';
      specification3 = '';
      number3 = '';
    }
    if (goodsname4 == '0' || specification4 == '0') {
      goodsname4 = '';
      specification4 = '';
      number4 = '';
    }
    if (goodsname5 == '0' || specification5 == '0') {
      goodsname5 = '';
      specification5 = '';
      number5 = '';
    }
    // 关闭数据库
    await conn.close();
    setState(() {});
    print(goodsname1);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CompanyModel companyModel = widget.company;
    String companyname = companyModel.company;
    String address = companyModel.address;
    String name = companyModel.name;
    String tel = companyModel.tel;
    id = companyModel.id; //用于查找需求单
    needperId = companyModel.personid; //需求单用户id
    Lookup(id);

    List<TableDetail> list1 = [TableDetail('公司', '$companyname')];
    List<TableDetail> list2 = [TableDetail('地址', '$address')];
    List<TableDetail> list3 = [TableDetail('负责人', '$name')];
    List<TableDetail> list4 = [TableDetail('电话', '$tel')];
    List<TableDetail> list5 = [
      TableDetail('序号', '物品'),
      TableDetail('规格', '数量')
    ];
    List<TableDetail> list6 = [
      TableDetail('1', '$goodsname1'),
      TableDetail('$specification1', '$number1')
    ]; //注意数据问题
    List<TableDetail> list7 = [
      TableDetail('2', '$goodsname2'),
      TableDetail('$specification2', '$number2')
    ]; //注意数据问题
    List<TableDetail> list8 = [
      TableDetail('3', '$goodsname3'),
      TableDetail('$specification3', '$number3')
    ]; //注意数据问题
    List<TableDetail> list9 = [
      TableDetail('4', '$goodsname4'),
      TableDetail('$specification4', '$number4')
    ]; //注意数据问题
    List<TableDetail> list10 = [
      TableDetail('5', '$goodsname5'),
      TableDetail('$specification5', '$number5')
    ]; //注意数据问题
    List<TableDetail> list11 = [TableDetail('合计数量', '$total')]; //注意数据问题
    List tableList = [
      list1,
      list2,
      list3,
      list4,
      list5,
      list6,
      list7,
      list8,
      list9,
      list10,
      list11
    ];
    priorList = [
      '$goodsname1',
      '$specification1',
      '$number1',
      '$goodsname2',
      '$specification2',
      '$number2',
      '$goodsname3',
      '$specification3',
      '$number3',
      '$goodsname4',
      '$specification4',
      '$number4',
      '$goodsname5',
      '$specification5',
      '$number5',
    ];

    return Container(
      child: TableStyle(tableList),
    );
  }
}
