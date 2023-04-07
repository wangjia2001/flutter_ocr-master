import 'package:flutter/material.dart';

class Approval extends StatefulWidget {         //审批功能具体实现部分
  @override
  _ApprovalState createState() => _ApprovalState();
}

class _ApprovalState extends State<Approval> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Text('审批'),
    );
  }
}