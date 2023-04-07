import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_ocr/HomePage.dart';
import 'Login/login.dart';

List<CameraDescription> cameras;
CameraDescription camera;
Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  camera = cameras[0];
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: mDefaultTheme,
    routes: <String, WidgetBuilder>{
      "/login": (BuildContext context) => LoginPage(), //登录页面
      // '/HomePage': (BuildContext context) => HomePage(username: Username),
    },
    home: new LoginPage(),
  ));
}

final ThemeData mDefaultTheme = new ThemeData(
  primaryColor: Colors.blue[200],
  // scaffoldBackgroundColor: Color(0XFF8f98e0),
  scaffoldBackgroundColor: Colors.blue[50],
  cardColor: Colors.blue[200],
);
