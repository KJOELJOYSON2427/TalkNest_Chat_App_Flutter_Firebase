import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_project/Config/images.dart';
import 'package:my_project/Controller/CallController.dart';
import 'package:my_project/Controller/ChatContoller.dart';
import 'package:my_project/Controller/Profileontroller.dart';
import 'package:my_project/Model/ChatModel.dart';
import 'package:my_project/Model/UserModel.dart';
import 'package:my_project/Pages/CallPage/AudioCall.dart';
import 'package:my_project/Pages/CallPage/VideoCall.dart';
import 'package:my_project/Pages/Chat/Widgets/ChatBubble.dart';
import 'package:my_project/Pages/Chat/Widgets/MessageSendButtom.dart';
import 'package:my_project/Pages/UserProfile/ProfilePage.dart';

class Chatpage extends StatelessWidget {
  final UserModel userModel;
  const Chatpage({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    CallController callController = Get.put(CallController());
    Chatcontoller chatcontoller = Get.put(Chatcontoller());
    TextEditingController messageController = TextEditingController();
    ProfileController profileController = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            Get.to(UserProfile(userModel: userModel));
          },
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              // width: 50,
              //height: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  userModel.profileImage ?? AssestsImage.defaultProfileUrl,
                ),
              ),
            ),
          ),
        ),
        title: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            Get.to(UserProfile(userModel: userModel));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userModel.name ?? "Anonymus",
                style: Theme.of(context).textTheme.bodyLarge,
              ),

              StreamBuilder(
                stream: chatcontoller.getStatus(userModel.id!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text(
                      ".......",
                      style: Theme.of(context).textTheme.labelSmall,
                    );
                  } else {
                    return Text(
                      snapshot.data!.status ?? "Offline",
                      style: TextStyle(
                        fontSize: 12,
                        color:
                            snapshot.data!.status == "Online"
                                ? Colors.green
                                : Colors.grey,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(AudioCallPage(target: userModel));
              callController.callAnyoneAction(
                userModel,
                profileController.currentUser.value,
                "audio",
              );
            },
            icon: Icon(Icons.phone),
          ),

          IconButton(onPressed: () {
            Get.to(Videocall(target: userModel));
              callController.callAnyoneAction(
                userModel,
                profileController.currentUser.value,
                "video",
              );
          }, icon: Icon(Icons.video_call)),
          
          
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  StreamBuilder<List<ChatModel>>(
                    stream: chatcontoller.getMessages(userModel.id!),

                    builder: (context, snapShot) {
                      if (snapShot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapShot.hasError) {
                        return Center(child: Text("Error ${snapShot.error}"));
                      }
                      if (snapShot.hasError) {
                        return Center(child: Text("No Messages"));
                      }

                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 70,
                          top: 10,
                          left: 10,
                          right: 10,
                        ),
                        child: ListView.builder(
                          reverse: true,
                          itemCount: snapShot.data!.length,
                          itemBuilder: (context, index) {
                            DateTime timestamp = DateTime.parse(
                              snapShot.data![index].timestamp!,
                            );
                            String formattedTime = DateFormat(
                              'hh:mm a',
                            ).format(timestamp);
                            return Chatbubble(
                              message: snapShot.data![index].message!,
                              isComing:
                                  snapShot.data![index].receiverId ==
                                  profileController.currentUser.value.id,
                              time: formattedTime,
                              status: "read",
                              imageURl: snapShot.data![index].imageUrl ?? "",
                            );
                          },
                        ),
                      );
                    },
                  ),
                  Obx(
                    () =>
                        (chatcontoller.selectedImagePath.value != "")
                            ? Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 10),

                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: FileImage(
                                          File(
                                            chatcontoller
                                                .selectedImagePath
                                                .value,
                                          ),
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.primaryContainer,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    height: 400,
                                  ),
                                  Positioned(
                                    right: 0,
                                    child: IconButton(
                                      onPressed: () {
                                        chatcontoller.selectedImagePath.value =
                                            "";
                                      },
                                      icon: Icon(Icons.close),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            : Container(),
                  ),
                ],
              ),
            ),
            Messagesendbuttom(userModel: userModel),
          ],
        ),
      ),
    );
  }
}
