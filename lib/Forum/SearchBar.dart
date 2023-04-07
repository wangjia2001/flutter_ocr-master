import 'package:flutter/material.dart';
///搜索控件widget
class SearchBar extends StatelessWidget {
  FocusNode blankNode = FocusNode();          //设置点击其他位置时键盘消失

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius:BorderRadius.circular(20),
        border: Border.all(color: Colors.black),
        color: Colors.white,          //搜索框背景
      ),
      height: 40,
      child:GestureDetector(
        child:TextFormField(
          cursorColor: Colors.white,
          decoration: InputDecoration(
            hintText: '搜索',
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(Icons.search),
            alignLabelWithHint: true,
            hintStyle:TextStyle(
                height: 2.0,
                color: Colors.black
            ) ,
            enabledBorder: OutlineInputBorder(            /*边角*/
              borderRadius:BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colors.white, //边线颜色为白色
                width: 1, //边线宽度为2
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white, //边框颜色为白色
                width: 1, //宽度为5
              ),
              borderRadius:BorderRadius.circular(20),
            ),
          ),
          style: TextStyle(
            fontSize: 14,
            textBaseline:TextBaseline.alphabetic,
          ),
        ),
        onTap: (){
          FocusScope.of(context).requestFocus(blankNode);       //在其他位置时输入键盘取消
        },
      ),
    );
  }
}