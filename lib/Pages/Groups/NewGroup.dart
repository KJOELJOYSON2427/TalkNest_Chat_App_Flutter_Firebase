import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/Config/images.dart';
import 'package:my_project/Controller/ContactController.dart';
import 'package:my_project/Controller/GroupController.dart';
import 'package:my_project/Pages/Groups/NewGroup/GroupTile.dart';
import 'package:my_project/Pages/Groups/SelectedMemberList.dart';
import 'package:my_project/Pages/HomePage/ChatTitle.dart';

class NewGroup extends StatelessWidget {
  const NewGroup({super.key});

  @override
  Widget build(BuildContext context) {
    Contactcontroller contactController = Get.put(Contactcontroller());
    GroupController groupController = Get.put(GroupController());
    return Scaffold(
      appBar: AppBar(title: const Text("New Group")),
      floatingActionButton: FloatingActionButton(
        backgroundColor:
            groupController.groupMembers.isEmpty
                ? Colors.grey
                : Theme.of(context).colorScheme.primary,
        onPressed: () {
          if (groupController.groupMembers.isEmpty) {
            Get.snackbar("Error", "Please select atleast one member");
          } else {
            Get.to(GroupTitle());
          }
        },
        child: Icon(
          Icons.arrow_forward,
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SelectedMembers(),
            SizedBox(height: 10),
            Text(
              "Contacts on TalkNest",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            SizedBox(height: 10),
            Expanded(
              child: StreamBuilder(
                stream: contactController.getContacts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No contacts found"));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            groupController.selectMember(snapshot.data![index]);
                          },
                          child: ChatTitle(
                            imageUrl:
                                snapshot.data![index].profileImage ??
                                AssestsImage.defaultProfileUrl,
                            name: snapshot.data![index].name ?? "No Name",
                            lastChat: snapshot.data![index].about ?? "",
                            lastTime: "",
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
