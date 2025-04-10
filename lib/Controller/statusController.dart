import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Statuscontroller extends GetxController with WidgetsBindingObserver {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print('AppLifeCycleState: $state');
    if (state == AppLifecycleState.inactive) {
      await db.collection("users").doc(auth.currentUser!.uid).update({
        "Status": "Offline",
      });
    } else if (state == AppLifecycleState.resumed) {
      await db.collection("users").doc(auth.currentUser!.uid).update({
        "Status": "Online",
      });
    }
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }
}
