import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_project/Config/images.dart';
import 'package:my_project/Controller/GroupController.dart';
import 'package:my_project/Controller/Profileontroller.dart';
import 'package:my_project/Model/UserModel.dart';

class GroupMemberInfo extends StatelessWidget {
  final String userEmail;
  final String groupId;
  final String profileImage;
  final String userName;

  const GroupMemberInfo({
    super.key,
    required this.userEmail,
    required this.profileImage,
    required this.userName,
    required this.groupId,
  });

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());
    return SingleChildScrollView(
      // ✅ Added to prevent overflow
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                          100,
                        ), // 🔥 Rounded corners
                        child: Image.network(
                          profileImage,
                          height: 100,
                          width: 100, // Optional: set width for better layout
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) => Icon(Icons.error),
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(child: CircularProgressIndicator());
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        userName,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        userEmail,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 50,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AssestsImage.profileAudioCall,
                              width: 25,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Call",
                              style: TextStyle(color: Color(0xff039c00)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AssestsImage.profileVideoCall,
                              color: Color(0xffFF9900),
                              width: 25,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Video",
                              style: TextStyle(color: Color(0xffFF9900)),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          var newMember = UserModel(
                            email: "Jemkmk2@gmail.com",
                            name: "jorklrk",
                            profileImage: AssestsImage.defaultProfileUrl,
                            role: "admin",
                          );
                          groupController.addMemberToGroup(groupId, newMember);
                        },
                        child: Container(
                          height: 50,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AssestsImage.groupAddUser,
                                width: 25,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Add",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
