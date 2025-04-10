import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_project/Config/images.dart';
import 'package:my_project/Controller/ChatContoller.dart';
import 'package:my_project/Controller/GroupController.dart';
import 'package:my_project/Controller/Profileontroller.dart';
import 'package:my_project/Model/ChatModel.dart';
import 'package:my_project/Model/GroupModel.dart';
import 'package:my_project/Model/UserModel.dart';
import 'package:my_project/Pages/Chat/Widgets/ChatBubble.dart';
import 'package:my_project/Pages/Chat/Widgets/MessageSendButtom.dart';
import 'package:my_project/Pages/GroupChat/GroupTypeMessage.dart';
import 'package:my_project/Pages/GroupInfo/GroupInfo.dart';
import 'package:my_project/Pages/UserProfile/ProfilePage.dart';

class GroupChatPage extends StatelessWidget {
  final GroupModel groupModel;
  const GroupChatPage({super.key, required this.groupModel});

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());

    ProfileController profileController = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            // Get.to(UserProfile(userModel: userModel));
          },
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              // width: 50,
              //height: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  groupModel.profileUrl == ""
                      ? AssestsImage.defaultProfileUrl
                      : groupModel.profileUrl!,
                ),
              ),
            ),
          ),
        ),
        title: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            Get.to(GroupInfo(
              groupModel: groupModel,
            ));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                groupModel.name! ?? "Group Name",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text("Online", style: Theme.of(context).textTheme.labelSmall),
            ],
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.phone)),

          IconButton(onPressed: () {}, icon: Icon(Icons.video_call)),
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
                    stream: groupController.getGroupMessages(groupModel.id!),

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
                              imageURl: snapShot.data![index].imageUrl ?? "",
                              isComing:
                                  snapShot.data![index].senderId !=
                                  profileController.currentUser.value.id,
                              status: "read",
                              time: formattedTime,
                            );
                          },
                        ),
                      );
                    },
                  ),
                  Obx(
                    () =>
                        (groupController.selectedImagePath.value != "")
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
                                            groupController
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
                                        groupController
                                            .selectedImagePath
                                            .value = "";
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
            GroupMessagesendButton(groupModel: groupModel),
          ],
        ),
      ),
    );
  }
}
