import 'package:flutter/material.dart';

class feedback extends StatefulWidget{
  @override
  _feedbackState createState()=>_feedbackState();
}
class _feedbackState extends State<feedback>{

  TextEditingController controller=TextEditingController();

  void commit(){
    if(controller.text.length==0){
      showDialog(context: context, builder: (context)=>AlertDialog(title:Text('请输入内容'),));
    }else{      //提交留言，需要链接服务器
      showDialog(context: context, builder: (context)=>AlertDialog(title:Text('暂时不能使用'),));
    }
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('意见反馈'),
      ),
      body: Container(
        child:Column(
          mainAxisAlignment:MainAxisAlignment.start,
          crossAxisAlignment:CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                height:50.0
            ),
            SizedBox(       //放大留言框
              width:380.0,
              child:TextField(
                controller:controller,
                decoration: InputDecoration(
                  hintText: '请留言',
                  labelText: '请留言',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            SizedBox(
              width: 220.0,
              height: 48.0,
              child: RaisedButton(
                  child: Text(
                    '给我们留言',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  color: Colors.red,
                  colorBrightness: Brightness.dark,
                  textColor: Colors.white,
                  padding: EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    top:5.0,
                    bottom: 5.0,
                  ),
                  shape: RoundedRectangleBorder(
                    side:BorderSide(
                      width: 1.0,
                      color: Colors.white,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(4.0),
                      topLeft: Radius.circular(4.0),
                      bottomLeft: Radius.circular(4.0),
                      bottomRight: Radius.circular(4.0),
                    ),
                  ),
                  onPressed: (){
                    commit();
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}