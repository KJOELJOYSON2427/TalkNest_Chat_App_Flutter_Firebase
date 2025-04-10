import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/Config/CustomMessage.dart';
import 'package:my_project/Controller/Profileontroller.dart';
import 'package:my_project/Model/ChatModel.dart';
import 'package:my_project/Model/GroupModel.dart';
import 'package:my_project/Model/UserModel.dart';
import 'package:my_project/Pages/HomePage/HomePage.dart';
import 'package:uuid/uuid.dart';

class GroupController extends GetxController {
  RxList<UserModel> groupMembers = <UserModel>[].obs;

  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  var uuid = Uuid();
  RxBool isLoading = false.obs;
  RxString selectedImagePath = "".obs;
  RxList<GroupModel> groupList = <GroupModel>[].obs;

  ProfileController profileController = Get.put(ProfileController());

  @override
  void onInit() {
    super.onInit();
    getGroups();
  }

  void selectMember(UserModel user) {
    if (groupMembers.contains(user)) {
      groupMembers.remove(user);
    } else {
      groupMembers.add(user);
    }
  }

  Future<void> createGroup(String groupName, String imagePath) async {
    isLoading.value = true;
    String groupId = uuid.v6();
    groupMembers.add(
      UserModel(
        id: auth.currentUser!.uid,
        name: profileController.currentUser.value.name,
        profileImage: profileController.currentUser.value.profileImage,
        email: profileController.currentUser.value.email,
        role: "admin",
      ),
    );

    try {
      String imageUrl = await profileController.cloudinaryservice.uploadImage(
        File(imagePath),
      );
      print(imageUrl);

      await db.collection("groups").doc(groupId).set({
        "id": groupId,
        "name": groupName,
        "profileUrl": imageUrl,
        "members": groupMembers.map((e) => e.toJson()).toList(),
        "createdBy": auth.currentUser!.uid,
        "createdAt": DateTime.now().toString(),
        "timestamp": DateTime.now().toString(),
      });

      getGroups();
      successMessage("Group Created");
      Get.offAll(Homepage());
      isLoading.value = false;
    } catch (e) {
      print(e);
    }
  }

  Future<void> getGroups() async {
    isLoading.value = true;
    List<GroupModel> tempGroup = [];
    await db.collection("groups").get().then((value) {
      tempGroup = value.docs.map((e) => GroupModel.fromJson(e.data())).toList();
    });
    groupList.clear();
    groupList.value =
        tempGroup
            .where(
              (e) => e.members!.any(
                (element) => (element.id == auth.currentUser!.uid),
              ),
            )
            .toList();
    isLoading.value = false;
  }

  Future<void> sendGroupMessage(
    String message,
    String groupId,
    String imagePath,
  ) async {
    isLoading.value = true;
    String imageUrl = "";
    try {
      if (imagePath.isNotEmpty) {
        print(imagePath + "prr");

        imageUrl = await profileController.cloudinaryservice.uploadImage(
          File(imagePath),
        );
      }

      var chatGroupId = uuid.v6();
      var newGroupChat = ChatModel(
        id: chatGroupId,
        message: message,
        imageUrl: imageUrl,
        senderId: profileController.currentUser.value.id,
        timestamp: DateTime.now().toString(),
      );

      await db
          .collection("groups")
          .doc(groupId)
          .collection("messages")
          .doc(chatGroupId)
          .set(newGroupChat.toJson());
    } catch (e) {
      debugPrint("Error sending group message: $e");
      // Optionally show a toast or snackbar
      Get.snackbar(
        "Error",
        "Failed to send message. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    selectedImagePath.value = "";
    isLoading.value = false;
  }

  Stream<List<ChatModel>> getGroupMessages(String groupId) {
    return db
        .collection("groups")
        .doc(groupId)
        .collection("messages")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map(
          (querySnapshot) =>
              querySnapshot.docs
                  .map((doc) => ChatModel.fromJson(doc.data()))
                  .toList(),
        );
  }

  Future<void> addMemberToGroup(String groupId, UserModel user) async {
    isLoading.value = true;

    await db.collection("groups").doc(groupId).update({
      "members": FieldValue.arrayUnion([user.toJson()]),
    });
    getGroups();
    isLoading.value = false;
  }
}
