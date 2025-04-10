import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/Config/PagePath.dart';
import 'package:my_project/Config/Themes.dart';
import 'package:my_project/Controller/CallController.dart';
import 'package:my_project/Pages/Auth/AuthPage.dart';
import 'package:my_project/Pages/HomePage/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_project/Pages/UserProfile/ProfilePage.dart';

import 'package:my_project/Pages/SplaceScreen/SplaceScreen.dart';
import 'package:my_project/Pages/Welcome/WelcomePage.dart';
import 'package:my_project/firebase_options.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    CallController callController = Get.put(CallController());

    return GetMaterialApp(
      builder: FToastBuilder(),
      title: 'ChatWorld',
      theme: lightTheme,
      darkTheme: darkTheme,
      getPages: pagePath,
      themeMode: ThemeMode.dark, //start
      home: Splacescreen(),
    );
  }
}
