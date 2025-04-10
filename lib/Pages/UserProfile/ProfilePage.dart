import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_project/Config/images.dart';
import 'package:my_project/Controller/AuthController.dart';
import 'package:my_project/Controller/Profileontroller.dart';
import 'package:my_project/Model/UserModel.dart';
import 'package:my_project/Pages/UserProfile/Widgets/UserProfile.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key, required this.userModel});
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    Authcontroller authcontroller = Get.put(Authcontroller());

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed("/updateProfilePage");
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            LoginUserprofile(
              profileImage:
                  userModel.profileImage ?? AssestsImage.defaultProfileUrl,
              userName: userModel.name ?? "Anonymus",
              userEmail: userModel.email ?? "",
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                authcontroller.logoutUser();
              },
              child: Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
