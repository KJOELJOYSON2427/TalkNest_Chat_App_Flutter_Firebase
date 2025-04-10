import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:my_project/Model/UserModel.dart';

class Dbcontroller extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;
  RxList<UserModel> userList = <UserModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await getUserList();
  }

  Future<void> getUserList() async {
    isLoading.value = true;
    await db
        .collection("users")
        .get()
        .then(
          (value) => {
            userList.value =
                value.docs.map((e) => UserModel.fromJson(e.data())).toList(),
          },
        );
    isLoading.value = false;
  }
}
