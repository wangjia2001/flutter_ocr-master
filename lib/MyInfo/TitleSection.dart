import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class titleSection extends StatelessWidget {
  titleSection(String name);

  Widget build(BuildContext context) {
    return Container(
      //最开始的模块
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(50),
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage("assets/images/1.jpg"), fit: BoxFit.cover),
            ),
          ),
          SizedBox(width: 20), //设置组件间位置
          Text(
            'name', //需要替换
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ), //需要从数据库中得到信息
        ],
      ),
    );
  }
}
