import 'package:flutter/material.dart';

class Bookkeeping extends StatefulWidget {         //记账薄功能具体实现部分
  @override
  _BookkeepingState createState() => _BookkeepingState();
}

class _BookkeepingState extends State<Bookkeeping> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Text('记账薄'),
    );
  }
}