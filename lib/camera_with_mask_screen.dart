import 'package:avatar_view/avatar_view.dart';
import 'package:camera_deep_ar/camera_deep_ar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class CameraWithMaskScreen extends StatefulWidget {
  @override
  _CameraWithMaskScreenState createState() => _CameraWithMaskScreenState();
}

class _CameraWithMaskScreenState extends State<CameraWithMaskScreen> {
  CameraDeepArController cameraDeepArController;
  String platFormVersion = "Unknown";
  int currentPage = 0;
  final vp = PageController(viewportFraction: .24);
  Effects currentEffects = Effects.none;
  Masks currentMask = Masks.none;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            //Deep Ar Camera
            CameraDeepAr(
              onCameraReady: (isReady) {
                platFormVersion = "Camera Status $isReady";
                print(platFormVersion);
                setState(() {});
              },
              androidLicenceKey:
                  "d564a07a322db6c43126272d65e9ec0001cc1ae5e5c9fc4ed57118d2a7661f8af4e086e181ac9046",
              onImageCaptured: (path) {
                platFormVersion = "Image save at $path";
                print(platFormVersion);
                setState(() {});
              },
              cameraDeepArCallback: (controller) async {
                cameraDeepArController = controller;
                setState(() {});
              },
            ),

            //Face Mask filters - Icon buttons
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: FlatButton(
                        child: Icon(Icons.camera_enhance),
                        color: Colors.white54,
                        padding: EdgeInsets.all(15.0),
                        onPressed: () {
                          if (null == cameraDeepArController) return;
                          cameraDeepArController.snapPhoto();
                        },
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(8, (page) {
                          bool active = currentPage == page;
                          return Platform.isIOS
                              ? GestureDetector(
                                  onTap: () {
                                    currentPage = page;
                                    cameraDeepArController.changeMask(page);
                                    setState(() {});
                                  },
                                  child: AvatarView(
                                    radius: active ? 65 : 30,
                                    backgroundColor: Colors.yellow,
                                    borderWidth: 2,
                                    isOnlyText: false,
                                    avatarType: AvatarType.CIRCLE,
                                    borderColor: Colors.red,
                                    imagePath: "assets/${page.toString()}.jpg",
                                    placeHolder: Icon(Icons.person, size: 50),
                                    errorWidget: Container(
                                      child: Icon(Icons.error, size: 50),
                                    ),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    currentPage = page;
                                    cameraDeepArController.changeMask(page);
                                    setState(() {});
                                  },
                                  child: AvatarView(
                                    radius: active ? 65 : 30,
                                    backgroundColor: Colors.yellow,
                                    borderWidth: 2,
                                    isOnlyText: false,
                                    avatarType: AvatarType.CIRCLE,
                                    borderColor: Colors.red,
                                    imagePath: "assets/${page.toString()}.jpg",
                                    placeHolder: Icon(Icons.person, size: 50),
                                    errorWidget: Container(
                                      child: Icon(Icons.error, size: 50),
                                    ),
                                  ),
                                );
                        }),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
