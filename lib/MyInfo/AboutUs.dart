import 'package:flutter/material.dart';

import 'FunctionRealization/Feedback.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.message),
            title: Text('我的公司'),
            trailing: new Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigator.push(context,MaterialPageRoute(builder: (context)=>MyCompany()));
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text('该功能暂时不能使用'),
                      ));
            },
          ),
          Divider(
            height: 10.0,
            color: Colors.grey,
          ),
          ListTile(
            leading: Icon(Icons.monetization_on),
            title: Text('记账薄'),
            trailing: new Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigator.push(context,MaterialPageRoute(builder: (context)=>Bookkeeping()));
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text('该功能暂时不能使用'),
                      ));
            },
          ),
          Divider(
            height: 10.0,
            color: Colors.grey,
          ),
          ListTile(
            leading: Icon(Icons.how_to_reg_outlined),
            title: Text('审批'),
            trailing: new Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => Approval()));
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('该功能暂时不能使用'),
                  ));
            },
          ),
          Divider(
            height: 10.0,
            color: Colors.grey,
          ),
          ListTile(
            leading: Icon(Icons.supervised_user_circle),
            title: Text('合作伙伴'),
            trailing: new Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigator.push(context,MaterialPageRoute(builder: (context)=>CooperativePartner()));
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text('该功能暂时不能使用'),
                      ));
            },
          ),
          Divider(
            height: 10.0,
            color: Colors.grey,
          ),
          ListTile(
            leading: Icon(Icons.comment),
            title: Text('意见反馈'),
            trailing: new Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => feedback()));
            },
          ),
          Divider(
            height: 10.0,
            color: Colors.grey,
          ),
          ListTile(
            leading: Icon(Icons.build_circle),
            title: Text('设置'),
            trailing: new Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigator.push(context,MaterialPageRoute(builder: (context)=>SetUp()));
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('该功能暂时不能使用'),
                  ));
            },
          ),
          Divider(
            height: 10.0,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
