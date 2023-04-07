import 'package:flutter/material.dart';
class SecondNullListCard extends StatefulWidget {
  @override
  _SecondNullListCardState createState() => _SecondNullListCardState();
}

class _SecondNullListCardState extends State<SecondNullListCard> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 1, top: 3, right: 1,bottom: 5),     //边距
      padding: EdgeInsets.only(left:1,top:18,right: 1,bottom: 4),      //间距大小
      decoration: new BoxDecoration(                        //框颜色
        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10.0)],
        color: Colors.white,
        borderRadius: BorderRadius.circular(18)
      ),
      child: new Row(
        children: [
          new Expanded(
            child: new Text(
              "无供货单信息！",
              textAlign: TextAlign.center,
              style: new TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 90),
        ],
      ),
    );
  }
}