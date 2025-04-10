import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_project/Config/images.dart';
import 'package:my_project/Controller/ChatContoller.dart';
import 'package:my_project/Controller/ImagePicker.dart';
import 'package:my_project/Model/UserModel.dart';
import 'package:my_project/Widgets/ImagePickerBottomSheet.dart';

class Messagesendbuttom extends StatelessWidget {
  final UserModel userModel;
  
  const Messagesendbuttom({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    Chatcontoller chatcontoller = Get.put(Chatcontoller());
    ImagePickerController imagePickerController = ImagePickerController();
    TextEditingController messageController = TextEditingController();
    RxString message = "".obs;
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
                print("ABD" + message.value);
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
                chatcontoller.selectedImagePath.value == ""
                    ? InkWell(
                      onTap: () async {
                        await ImagePickerBottomSheet(
                          context,
                          chatcontoller.selectedImagePath,
                          imagePickerController,
                        );
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
                        chatcontoller.selectedImagePath.value != ""
                    ? Container(
                      height: 30,
                      width: 30,
                      child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          if (messageController.text.isNotEmpty ||
                              chatcontoller
                                  .selectedImagePath
                                  .value
                                  .isNotEmpty) {
                            chatcontoller.sendMessage(
                              userModel.id!,
                              messageController.text,
                              userModel,
                            );
                            messageController.clear();
                            message.value = "";
                          }
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          child:
                              chatcontoller.isLoading.value
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
