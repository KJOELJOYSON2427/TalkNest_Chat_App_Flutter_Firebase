import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/Config/images.dart';
import 'package:my_project/Controller/ChatContoller.dart';
import 'package:my_project/Controller/ContactController.dart';
import 'package:my_project/Controller/DBController.dart';
import 'package:my_project/Pages/Chat/ChatPage.dart';
import 'package:my_project/Pages/ContactPage/Widgets/ContactSearch.dart';
import 'package:my_project/Pages/ContactPage/Widgets/NewContactTile.dart';
import 'package:my_project/Pages/Groups/NewGroup.dart';
import 'package:my_project/Pages/HomePage/ChatTitle.dart';

class Contactpage extends StatelessWidget {
  const Contactpage({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isSearchEnable = false.obs;
    Chatcontoller chatcontoller = Get.put(Chatcontoller());
    Contactcontroller contactcontroller = Get.put(Contactcontroller());
    return Scaffold(
      appBar: AppBar(
        title: Text("Select contact"),
        actions: [
          IconButton(
            onPressed: () {
              isSearchEnable.value = !isSearchEnable.value;
            },
            icon: Obx(
              () =>
                  isSearchEnable.value ? Icon(Icons.close) : Icon(Icons.search),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Obx(() => isSearchEnable.value ? ContactSearch() : SizedBox()),
            SizedBox(height: 10),

            NewcontactTile(
              btnName: "New Contact",
              icon: Icons.person,
              onTap: () {},
            ),
            SizedBox(height: 10),

            NewcontactTile(
              btnName: "New Group",
              icon: Icons.group_add,
              onTap: () {
                Get.to(NewGroup());
              },
            ),
            SizedBox(height: 10),

            Row(children: [Text("Contact in TalkNest")]),
            SizedBox(width: 10),
            SizedBox(height: 10),
            Obx(
              () => Column(
                children:
                    contactcontroller.userList
                        .map(
                          (e) => InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              Get.to(Chatpage(userModel: e));
                            },
                            child: ChatTitle(
                              imageUrl:
                                  e.profileImage ??
                                  AssestsImage.defaultProfileUrl,
                              name: e.name ?? "Anonymus User",
                              lastChat: e.about ?? "Hey There",
                              lastTime:
                                  e.email ==
                                          chatcontoller.auth.currentUser!.email
                                      ? "You"
                                      : " ",
                            ),
                          ),
                        )
                        .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
