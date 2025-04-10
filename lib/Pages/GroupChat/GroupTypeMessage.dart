import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_project/Config/images.dart';
import 'package:my_project/Controller/ChatContoller.dart';
import 'package:my_project/Controller/GroupController.dart';
import 'package:my_project/Controller/ImagePicker.dart';
import 'package:my_project/Model/GroupModel.dart';
import 'package:my_project/Model/UserModel.dart';
import 'package:my_project/Widgets/ImagePickerBottomSheet.dart';

class GroupMessagesendButton extends StatelessWidget {
  final GroupModel groupModel;

  const GroupMessagesendButton({super.key, required this.groupModel});

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());
    ImagePickerController imagePickerController = ImagePickerController();
    TextEditingController messageController = TextEditingController();
    RxString message = "".obs;
    RxString imagePath = "".obs;
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            child: SvgPicture.asset(AssestsImage.chatEmoji),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              onChanged: (Value) {
                message.value = Value;
                print("ABD de npr" + message.value);
              },
              controller: messageController,
              decoration: InputDecoration(
                filled: false,
                hintText: "Type message ...",
                hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
          ),
          Obx(
            () =>
                groupController.selectedImagePath.value == ""
                    ? InkWell(
                      onTap: () async {
                        await ImagePickerBottomSheet(
                          context,
                          groupController.selectedImagePath,
                          imagePickerController,
                        );
                        print(groupController.selectedImagePath.value);
                      },
                      child: Container(
                        child: SvgPicture.asset(AssestsImage.chatGallery),
                      ),
                    )
                    : SizedBox(),
          ),
          SizedBox(width: 10),
          Obx(
            () =>
                message.value != "" ||
                        groupController.selectedImagePath.value != ""
                    ? Container(
                      height: 30,
                      width: 30,
                      child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          groupController.sendGroupMessage(
                            messageController.text,
                            groupModel.id!,
                            groupController.selectedImagePath.value ,
                          );
                          messageController.clear();
                          message.value = "";
                        },

                        child: Container(
                          width: 30,
                          height: 30,
                          child:
                              groupController.isLoading.value
                                  ? CircularProgressIndicator()
                                  : SvgPicture.asset(AssestsImage.chatSendSvg),
                        ),
                      ),
                    )
                    : Container(
                      width: 30,
                      height: 30,
                      child: SvgPicture.asset(AssestsImage.chatMic),
                    ),
          ),
        ],
      ),
    );
  }
}
