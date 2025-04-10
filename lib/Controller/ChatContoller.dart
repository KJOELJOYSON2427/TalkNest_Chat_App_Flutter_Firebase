import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_project/Controller/ContactController.dart';
import 'package:my_project/Controller/Profileontroller.dart';
import 'package:my_project/Model/AudioCall.dart';
import 'package:my_project/Model/ChatModel.dart';
import 'package:my_project/Model/UserModel.dart';
import 'package:my_project/Model/chat_room_model/chat_room_model.dart';
import 'package:my_project/Service/CloudinaryService.dart';
import 'package:uuid/uuid.dart';

class Chatcontoller extends GetxController {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;
  RxString selectedImagePath = "".obs;
  Uuid uuid = Uuid();

  final Cloudinaryservice cloudinaryservice = Cloudinaryservice();
  ProfileController profileController = Get.put(ProfileController());
  Contactcontroller contactcontroller = Get.put(Contactcontroller());
  String getRoomId(String targetUserId) {
    String currentUserId = auth.currentUser!.uid;
    if (currentUserId.compareTo(targetUserId) > 0) {
      return currentUserId + targetUserId;
    } else {
      return targetUserId + currentUserId;
    }
  }

  UserModel getSender(UserModel currentUser, UserModel targetUser) {
    if (currentUser.id == null ||
        targetUser.id == null ||
        currentUser.id!.isEmpty ||
        targetUser.id!.isEmpty) {
      throw ArgumentError("User IDs cannot be null or empty");
    }

    return (currentUser.id!.compareTo(targetUser.id!) > 0)
        ? currentUser
        : targetUser;
  }

  UserModel getReceiver(UserModel currentUser, UserModel targetUser) {
    if (currentUser.id == null ||
        targetUser.id == null ||
        currentUser.id!.isEmpty ||
        targetUser.id!.isEmpty) {
      throw ArgumentError("User IDs cannot be null or empty");
    }

    return (currentUser.id!.compareTo(targetUser.id!) > 0)
        ? targetUser
        : currentUser;
  }

  Future<void> sendMessage(
    String targetUserId,
    String message,
    UserModel targetUser,
  ) async {
    isLoading.value = true;
    String chatId = uuid.v6();
    String roomId = getRoomId(targetUserId);
    DateTime timestamp = DateTime.now();
    String nowTime = DateFormat('hh:mm a').format(timestamp);

    UserModel sender = getSender(
      profileController.currentUser.value,
      targetUser,
    ); //greter

    UserModel reciever = getReceiver(
      profileController.currentUser.value,
      targetUser,
    ); //smaller

    RxString imageUrl = "".obs;
    if (selectedImagePath.value.isNotEmpty) {
      File file = File(selectedImagePath.value);
      imageUrl.value = await cloudinaryservice.uploadImage(file);
      selectedImagePath.value = "";
    }

    var newChatModel = ChatModel(
      id: chatId,
      message: message,
      imageUrl: imageUrl.value,
      senderName: profileController.currentUser.value.name,
      senderId: auth.currentUser!.uid,
      receiverId: targetUserId,
      timestamp: DateTime.now().toString(),
    );

    var roomDetails = ChatRoomModel(
      id: roomId,
      lastMessage: message,
      lastMessageTimestamp: nowTime,
      sender: sender,
      receiver: reciever,
      unReadMessNo: 0,
      timestamp: DateTime.now().toString(),
    );
    try {
      await db
          .collection("chats")
          .doc(roomId)
          .collection("messages")
          .doc(chatId)
          .set(newChatModel.toJson());

      await db.collection("chats").doc(roomId).set(roomDetails.toJson());

      await contactcontroller.saveContact(targetUser);
    } catch (e) {
      print(e);
    }
    isLoading.value = false;
  }

  Stream<List<ChatModel>> getMessages(String targetUserId) {
    String roomId = getRoomId(targetUserId);

    return db
        .collection("chats")
        .doc(roomId)
        .collection("messages")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map(
          (snapShot) =>
              snapShot.docs
                  .map((doc) => ChatModel.fromJson(doc.data()))
                  .toList(),
        );
  }

  Stream<UserModel> getStatus(String uid) {
    return db.collection('users').doc(uid).snapshots().map((event) {
      return UserModel.fromJson(event.data()!);
    });
  }

  Stream<List<CallModel>> getCalls() {
    return db
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("calls")
        .orderBy("timestamp")
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map((doc) => CallModel.fromJson(doc.data()))
                  .toList(),
        );
  }
}
