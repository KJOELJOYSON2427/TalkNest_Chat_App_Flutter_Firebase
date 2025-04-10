import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:my_project/Pages/Auth/AuthPage.dart';
import 'package:my_project/Pages/Chat/ChatPage.dart';
import 'package:my_project/Pages/ContactPage/ContactPage.dart';
import 'package:my_project/Pages/HomePage/HomePage.dart';
import 'package:my_project/Pages/UserProfile/ProfilePage.dart';
import 'package:my_project/Pages/UserProfile/UpdateProfile.dart';

var pagePath = [
  GetPage(
    name: "/authPage",
    page: () => AuthPage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: "/homePage",
    page: () => Homepage(),
    transition: Transition.rightToLeft,
  ),

  GetPage(
    name: "/updateProfilePage",
    page: () => UserUpdateProfile(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: "/contactPage",
    page: () => Contactpage(),
    transition: Transition.rightToLeft,
  ),
];
