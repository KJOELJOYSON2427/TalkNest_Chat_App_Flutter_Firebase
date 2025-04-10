import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/Config/ZegoCloudConfig.dart';
import 'package:my_project/Controller/ChatContoller.dart';
import 'package:my_project/Controller/Profileontroller.dart';
import 'package:my_project/Model/UserModel.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class AudioCallPage extends StatelessWidget {
  final UserModel target;
  const AudioCallPage({super.key, required this.target});

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());
    Chatcontoller chatcontoller = Get.put(Chatcontoller());
    var callId = chatcontoller.getRoomId(target.id!);
    return ZegoUIKitPrebuiltCall(
      appID: ZegoCloudconfig.appId, // your AppID,
      appSign: ZegoCloudconfig.appSign,
      userID: profileController.currentUser.value.id ?? "root",
      userName: profileController.currentUser.value.id ?? "root",
      callID: callId,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}
