import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_project/Controller/AuthController.dart';
import 'package:my_project/Controller/ImagePicker.dart';
import 'package:my_project/Controller/Profileontroller.dart';
import 'package:my_project/Widgets/PrimaryButton.dart';

class Profilepage extends StatelessWidget {
  const Profilepage({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isEdit = false.obs;
    RxString imagePath = "".obs;
    ProfileController profileController = Get.put(ProfileController());
    TextEditingController name = TextEditingController(
      text: profileController.currentUser.value.name,
    );
    TextEditingController email = TextEditingController(
      text: profileController.currentUser.value.email,
    );
    TextEditingController phone = TextEditingController(
      text: profileController.currentUser.value.phoneNumber,
    );
    TextEditingController about = TextEditingController(
      text: profileController.currentUser.value.about,
    );
    ImagePickerController imagePickerController = Get.put(
      ImagePickerController(),
    );
    Authcontroller authcontroller = Get.put(Authcontroller());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),

        actions: [
          IconButton(
            onPressed: () {
              authcontroller.logoutUser();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(
                              () =>
                                  isEdit.value
                                      ? InkWell(
                                        splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
                                        onTap: () async {
                                          imagePath.value =
                                              await imagePickerController
                                                  .pickImage(ImageSource.gallery);

                                          print(imagePath.value + " Picked");
                                        },
                                        child: Container(
                                          height: 200,
                                          width: 200,
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(
                                                  context,
                                                ).colorScheme.background,
                                            borderRadius: BorderRadius.circular(
                                              100,
                                            ),
                                          ),
                                          child:
                                              imagePath.value == ""
                                                  ? Icon(Icons.add)
                                                  : ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          100,
                                                        ),
                                                    child: Image.file(
                                                      File(imagePath.value),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                        ),
                                      )
                                      : Container(
                                        height: 200,
                                        width: 200,
                                        decoration: BoxDecoration(
                                          color:
                                              Theme.of(
                                                context,
                                              ).colorScheme.background,
                                          borderRadius: BorderRadius.circular(
                                            100,
                                          ),
                                        ),
                                        child:
                                            profileController
                                                            .currentUser
                                                            .value
                                                            .profileImage ==
                                                        null ||
                                                    profileController
                                                            .currentUser
                                                            .value
                                                            .profileImage ==
                                                        ""
                                                ? Icon(Icons.image)
                                                : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        100,
                                                      ),
                                                  child: Image.network(
                                                    profileController
                                                        .currentUser
                                                        .value
                                                        .profileImage!,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  
                                                ),
                                      ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Name Field with Obx
                        Obx(
                          () => TextField(
                            enabled: isEdit.value,
                            controller: name,
                            decoration: InputDecoration(
                              filled: isEdit.value,
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              labelText: "Name",
                              hintStyle: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // About Field with Obx
                        Obx(
                          () => TextField(
                            enabled: isEdit.value,
                            controller: about,
                            decoration: InputDecoration(
                              filled: isEdit.value,
                              prefixIcon: const Icon(
                                Icons.info,
                                color: Colors.white,
                              ),
                              labelText: "About",
                              hintStyle: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Email Field with Obx
                        TextField(
                          enabled: isEdit.value,
                          controller: email,
                          decoration: InputDecoration(
                            filled: isEdit.value,
                            prefixIcon: const Icon(
                              Icons.alternate_email_rounded,
                              color: Colors.white,
                            ),
                            labelText: "Email",
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Phone Field with Obx
                        Obx(
                          () => TextField(
                            enabled: isEdit.value,
                            controller: phone,
                            decoration: InputDecoration(
                              filled: isEdit.value,
                              prefixIcon: const Icon(
                                Icons.phone,
                                color: Colors.white,
                              ),
                              labelText: "Number",
                              hintStyle: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Edit / Save Button with Obx
                        profileController.isLoading.value
                            ? CircularProgressIndicator()
                            : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Obx(
                                  () =>
                                      isEdit.value
                                          ? Primarybutton(
                                            btnName: "Save",
                                            icon: Icons.save,
                                            onTap: () async {
                                              await profileController
                                                  .updateProfile(
                                                    imagePath.value,
                                                    name.text,
                                                    about.text,
                                                    phone.text,
                                                  );
                                              isEdit.value = false;
                                            },
                                          )
                                          : Primarybutton(
                                            btnName: "Edit",
                                            icon: Icons.edit,
                                            onTap: () {
                                              isEdit.value = true;
                                            },
                                          ),
                                ),
                              ],
                            ),

                        const SizedBox(height: 20),
                      ],
                    ),
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
