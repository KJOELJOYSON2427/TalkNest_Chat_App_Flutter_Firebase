import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class Splacecontroller extends GetxController {
  final auth = FirebaseAuth.instance;

  void onInit() async {
    super.onInit();
    await spaceHandle();
  }

  Future<void> spaceHandle() async {
    Future.delayed(Duration(seconds: 3), () {
      if (auth.currentUser == null) {
        Get.offAllNamed("/authPage");
      } else {
        Get.offAllNamed("/homePage");
        print(auth.currentUser!.email);
      }
    });
  }
}
