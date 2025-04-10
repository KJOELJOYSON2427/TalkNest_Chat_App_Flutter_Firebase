import 'package:flutter/material.dart';
import 'package:my_project/Config/images.dart';
import 'package:my_project/Model/GroupModel.dart';
import 'package:my_project/Pages/GroupInfo/GroupMemberInfo.dart';
import 'package:my_project/Pages/HomePage/ChatTitle.dart';


class GroupInfo extends StatelessWidget {
  final GroupModel groupModel;
  const GroupInfo({super.key, required this.groupModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(groupModel.name!),

        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            GroupMemberInfo(
              groupId:groupModel.id!,
              profileImage:
                  groupModel.profileUrl == ""
                      ? AssestsImage.defaultProfileUrl
                      : groupModel.profileUrl!,
              userName: groupModel.name!,
              userEmail: groupModel.description ?? "No Description available",
            ),

            SizedBox(height: 20),
            Text("Members", style: Theme.of(context).textTheme.labelSmall),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.surfaceVariant,
              ),
              child: Column(
                children:
                    groupModel.members!
                        .map(
                          (member) => ChatTitle(
                            imageUrl:
                                member.profileImage ??
                                AssestsImage.defaultProfileUrl,
                            name: member.name!,
                            lastChat: member.email!,
                            lastTime:
                                member.role == "admin" ? " Admin" : "Member",
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
