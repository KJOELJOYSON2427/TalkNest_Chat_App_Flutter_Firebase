import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/Config/images.dart';
import 'package:my_project/Controller/GroupController.dart';
import 'package:my_project/Pages/GroupChat/GroupChat.dart';
import 'package:my_project/Pages/HomePage/ChatTitle.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());

    return Obx(
      () => ListView(
        children:
            groupController.groupList
                .map(
                  (group) => InkWell(
                    onTap: () {
                      Get.to(GroupChatPage(groupModel: group));
                    },
                    child: ChatTitle(
                      imageUrl:
                          group.profileUrl == ""
                              ? AssestsImage.defaultProfileUrl
                              : group.profileUrl!,
                      name: group.name!,
                      lastChat: "Group Created",
                      lastTime: "Just Now",
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }
}
