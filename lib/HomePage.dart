import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:camera/camera.dart';
import 'Forum/ForumPage.dart';
import 'MyInfo/MyInfoPage.dart';
import 'Template/TemplatePage.dart';
import 'Project/ProjectPage.dart';
import 'ocr/Ocrmain.dart';
import 'MyInfo/PersonalInformation.dart';

String user;
List<CameraDescription> cameras;
CameraDescription camera;

class HomePage extends StatefulWidget {
  final String username;
  HomePage({Key key, @required this.username}) : super(key: key);

  //底部栏部分
  @override
  _HomePageState createState() {
    user = username;
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  // ignore: missing_return
  Future<Widget> camerastart() async {
    cameras = await availableCameras();
    camera = cameras[0];
  }

  var _currentIndex = 0;
  ProjectPage projectPage;
  TemplatePage templatePage;
  PersonalInformation personalInformation;
  ForumPage forumPage;

  currentPage() {
    switch (_currentIndex) {
      case 0:
        if (forumPage == null) {
          forumPage = new ForumPage(); //data
        }
        return forumPage;
      case 1:
        if (projectPage == null) {
          projectPage = new ProjectPage(username: user);
        }
        return projectPage;
      case 3:
        if (templatePage == null) {
          templatePage = new TemplatePage(username: user);
        }
        return templatePage;
      case 4:
        if (personalInformation == null) {
          personalInformation = new PersonalInformation(username: user);
        }
        return personalInformation;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        height: 80,
        width: 80,
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Colors.white,
        ),
        child: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async {
              cameras = await availableCameras();
              camera = cameras[0];
              // runApp(new MyOcr());
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return new MyHomePage();
              }));
            },
            backgroundColor: Colors.blue[200]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: new BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: ((index) {
          setState(() {
            _currentIndex = index;
          });
        }),
        items: [
          new BottomNavigationBarItem(
              title: new Text(
                '论坛',
                style: TextStyle(
                    color: _currentIndex == 0
                        ? Colors.blue[200]
                        : Color(0xff999999)),
              ),
              icon: Icon(Icons.forum_outlined)),
          new BottomNavigationBarItem(
              title: new Text(
                '项目',
                style: TextStyle(
                    color: _currentIndex == 1
                        ? Colors.blue[200]
                        : Color(0xff999999)),
              ),
              icon: Icon(Icons.folder_open)),
          new BottomNavigationBarItem(
              title: new Text(
                '',
                style: TextStyle(
                    color: _currentIndex == 2
                        ? Colors.blue[200]
                        : Color(0xff999999)),
              ),
              icon: Icon(Icons.note_add_outlined)),
          new BottomNavigationBarItem(
              title: new Text(
                '模板',
                style: TextStyle(
                    color: _currentIndex == 3
                        ? Colors.blue[200]
                        : Color(0xff999999)),
              ),
              icon: Icon(Icons.note_add_outlined)),
          new BottomNavigationBarItem(
              title: new Text(
                '我的',
                style: TextStyle(
                    color: _currentIndex == 4
                        ? Colors.blue[200]
                        : Color(0xff999999)),
              ),
              icon: Icon(Icons.account_circle_outlined)),
        ],
      ),
      body: currentPage(),
    );
  }
}
