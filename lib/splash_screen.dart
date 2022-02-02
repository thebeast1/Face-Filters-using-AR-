import 'package:ar_face_filters/camera_with_mask_screen.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      navigateAfterSeconds: CameraWithMaskScreen(),
      seconds: 3,
      title: Text("Ar Face Mask App",
          style: TextStyle(
              fontSize: 55,
              color: Colors.deepPurpleAccent,
              fontFamily: "Signatra")),
      image: Image.asset("assets/icon.png"),
      backgroundColor: Colors.white,
      photoSize: 140,
      loaderColor: Colors.deepPurple,
      loadingText: Text(
        "from Coding Cafe",
        style: TextStyle(
            fontSize: 16.0,
            color: Colors.deepPurpleAccent,
            fontFamily: "bolt semibold"),
      ),
    );
  }
}
