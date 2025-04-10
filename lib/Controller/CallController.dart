import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_project/Model/AudioCall.dart';
import 'package:my_project/Model/UserModel.dart';
import 'package:my_project/Pages/CallPage/AudioCall.dart';
import 'package:my_project/Pages/CallPage/VideoCall.dart';
import 'package:uuid/uuid.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:intl/date_symbol_data_local.dart';

class CallController extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final uuid = Uuid().v4();

  void onInit() {
    super.onInit();

    getCallsNotification().listen((List<CallModel> callList) {
      if (callList.isNotEmpty) {
        var callData = callList[0];
        if (callData.type == "audio") {
          audioCallNotification(callData);
        } else if (callData.type == "video") {
          videoCallNotification(callData);
        }
      }
    });
  }

  Future<void> audioCallNotification(CallModel callData) async {
    Get.snackbar(
      barBlur: 0,
      isDismissible: false,
      icon: Icon(Icons.call),
      duration: Duration(days: 1),
      backgroundColor: Colors.grey[900]!,
      onTap: (snack) {
        Get.to(
          AudioCallPage(
            target: UserModel(
              id: callData.callerUid,
              name: callData.callerName,
              email: callData.callerEmail,
              profileImage: callData.callerPic,
            ),
          ),
        );
        Get.back();
      },
      callData.callerName!,
      "Incoming Call",
      mainButton: TextButton(
        onPressed: () {
          endCall(callData);
          Get.back();
        },
        child: Text("End Call"),
      ),
    );
  }

  Future<void> callAnyoneAction(
    UserModel reciever,
    UserModel caller,
    String type,
  ) async {
    String id = uuid;
    DateTime timestamp = DateTime.now();
    String nowTime = DateFormat('hh:mm a').format(timestamp);
    var newCall = CallModel(
      id: id,
      callerName: caller.name,
      callerPic: caller.profileImage,
      callerUid: caller.id,
      callerEmail: caller.email,
      receiverName: reciever.name,
      receiverPic: reciever.profileImage,
      receiverUid: reciever.id,
      receiverEmail: reciever.email,
      status: "dialing",
      type: type,
      time: nowTime,
      timestamp: DateTime.now().toString(),
    );
    //when calling --> Call Model add
    try {
      await db
          .collection("notification")
          .doc(reciever.id)
          .collection("call")
          .doc(id)
          .set(newCall.toJson());

      await db
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection("calls")
          .doc(id)
          .set(newCall.toJson());
      await db
          .collection("users")
          .doc(reciever.id)
          .collection("calls")
          .doc(id)
          .set(newCall.toJson());

      Future.delayed(Duration(seconds: 20), () {
        endCall(newCall);
      });
    } catch (e) {
      print(e);
    }
  }

  Stream<List<CallModel>> getCallsNotification() {
    return db
        .collection("notification")
        .doc(auth.currentUser!.uid)
        .collection("call")
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map((doc) => CallModel.fromJson(doc.data()))
                  .toList(),
        );
  }

  Future<void> endCall(CallModel call) async {
    try {
      await db
          .collection("notification")
          .doc(call.receiverUid)
          .collection("call")
          .doc(call.id)
          .delete();
    } catch (e) {
      print(e);
    }
  }

  void videoCallNotification(CallModel callData) {
    Get.snackbar(
      barBlur: 0,
      isDismissible: false,
      icon: Icon(Icons.video_call),
      duration: Duration(days: 1),
      backgroundColor: Colors.grey[900]!,
      onTap: (snack) {
        Get.to(
          Videocall(
            target: UserModel(
              id: callData.callerUid,
              name: callData.callerName,
              email: callData.callerEmail,
              profileImage: callData.callerPic,
            ),
          ),
        );
        Get.back();
      },
      callData.callerName!,
      "Incoming Video call",
      mainButton: TextButton(
        onPressed: () {
          endCall(callData);
          Get.back();
        },
        child: Text("End Call"),
      ),
    );
  }
}
