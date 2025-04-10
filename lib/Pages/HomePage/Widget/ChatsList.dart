import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/Config/images.dart';
import 'package:my_project/Controller/ChatContoller.dart';
import 'package:my_project/Controller/ContactController.dart';
import 'package:my_project/Controller/Profileontroller.dart';
import 'package:my_project/Pages/Chat/ChatPage.dart';
import 'package:my_project/Pages/HomePage/ChatTitle.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    Chatcontoller chatcontoller = Get.put(Chatcontoller());

    ProfileController profileController = Get.put(ProfileController());
    Contactcontroller contactcontroller = Get.put(Contactcontroller());
    return RefreshIndicator(
      child: Obx(
        () => ListView(
          children:
              contactcontroller.chatRoomList
                  .map(
                    (e) => InkWell(
                      splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
                      onTap: () {
                        Get.to(
                          Chatpage(
                            userModel:
                                (e.receiver!.id ==
                                        profileController.currentUser.value.id
                                    ? e.sender
                                    : e.receiver)!,
                          ),
                        );
                      },
                      child: ChatTitle(
                        imageUrl:
                            (e.receiver!.id ==
                                    profileController.currentUser.value.id
                                ? e.sender!.profileImage
                                : e.receiver!.profileImage) ??
                            AssestsImage.defaultProfileUrl,
                        name:
                            (e.receiver!.id ==
                                    profileController.currentUser.value.id
                                ? e.sender!.name
                                : e.receiver!.name)!,
                        lastChat: e.lastMessage ?? "Last Message",
                        lastTime: e.lastMessageTimestamp ?? "09:03",
                      ),
                    ),
                  )
                  .toList(),
        ),
      ),
      onRefresh: () {
        return contactcontroller.getChatRoomList();
      },
    );
  }
}
