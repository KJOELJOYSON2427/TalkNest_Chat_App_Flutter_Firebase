import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:my_project/Model/UserModel.dart';
import 'package:my_project/Model/chat_room_model/chat_room_model.dart';

class Contactcontroller extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;
  RxList<UserModel> userList = <UserModel>[].obs;
  RxList<ChatRoomModel> chatRoomList = <ChatRoomModel>[].obs;
  @override
  void onInit() async {
    super.onInit();
    await getUserList();
    await getChatRoomList();
  }

  Future<void> getUserList() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("User is not authenticated");
      return;
    }

    isLoading.value = true;
    try {
      userList.clear();
      var snapshot = await db.collection("users").get();

      userList.assignAll(
        snapshot.docs.map((e) => UserModel.fromJson(e.data())).toList(),
      );
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print("Error: $e");
    }
  }

  Future<void> getChatRoomList() async {
    List<ChatRoomModel> totalChatRoom = [];

    await db.collection('chats').get().then((value) {
      totalChatRoom =
          value.docs.map((e) => ChatRoomModel.fromJson(e.data())).toList();
    });
    chatRoomList.value =
        totalChatRoom
            .where((e) => e.id!.contains(auth.currentUser!.uid))
            .toList();
  }

  Future<void> saveContact(UserModel user) async {
    //someone -> userModel  collections can delete with his id
    try {
      await db
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("contacts")
        .doc(user.id)
        .set(user.toJson());
    } catch (e) {
      print("Error while saving Contact" + e.toString());
    }

    
  }

  Stream<List<UserModel>> getContacts(){
     return db
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("contacts")
        .snapshots()
        .map(
          (snapShot) =>
              snapShot.docs
                  .map((doc) => UserModel.fromJson(doc.data()))
                  .toList(),
        );
  }


}
