import 'package:flutter/material.dart';
import 'TableDetail.dart';
class TableStyle extends StatefulWidget {
  final List tableList;                    //传值及其获取
  TableStyle(this.tableList);

  _TableStyleState createState() => _TableStyleState();

}

class _TableStyleState extends State<TableStyle> {            //表单数据获取
  List tableList = [];

  @override
  void initState() {
    super.initState();
    this.tableList = widget.tableList;     //数据初始化
  }

  _children(List<TableDetail> list) {
    List<Widget> children = [];
    List<Widget> children1 = list.map((tableDetail) {
      return Expanded(
          flex: 1,
          child: Container(
            child: Row(
              children: [
                _containerTitle(tableDetail.title),
                _verticalDivider(),
                _containerContent(tableDetail.content),
                _verticalDivider(),
              ],
            ),
          ));
    }).toList();
    children.add(_verticalDivider());//添加一行当中第一个竖线
    children.addAll(children1);
    return children;
  }
  _containerTitle(String title) {
    return Container(
      padding: EdgeInsets.only(left: 2, right: 2),
      alignment: Alignment.center,
      width: 120.0,
      child: Text(title, style: TextStyle(fontSize: 17), textAlign: TextAlign.center),
    );
  }

  _containerContent(String content) {
    return Expanded(
        child: Text(content,
            style: TextStyle(fontSize: 17),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis));
  }

  _verticalDivider() {              //垂直隔线
    return Container(
      width: 1.0,
      height: 40.0,
      decoration: BoxDecoration(color: Colors.grey),
    );
  }

  _horizontalDivider() {            //水平分隔线
    return Container(
      width: double.infinity,
      height: 0.2,
      decoration: BoxDecoration(color: Colors.grey),
    );
  }

  @override
  Widget build(BuildContext context) {
    this.tableList = widget.tableList;     //数据初始化
    return Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            _horizontalDivider(),//第一个根横线
            Column(
                children: tableList.map((child) {
                  return Column(
                    children: [Row(children: _children(child)), _horizontalDivider()],
                  );
                }).toList())
          ],
        )
    );
  }
}