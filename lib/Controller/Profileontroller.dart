import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_project/Model/UserModel.dart';
import 'package:my_project/Service/CloudinaryService.dart';

class ProfileController extends GetxController {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final Cloudinaryservice cloudinaryservice = Cloudinaryservice();
  Rx<UserModel> currentUser = UserModel().obs;
  RxBool isLoading = false.obs;

  void onInit() async {
    super.onInit();
    await getUserDetails();
  }

  Future<void> getUserDetails() async {
    await db
        .collection("users")
        .doc(auth.currentUser!.uid)
        .get()
        .then(
          (value) => {currentUser.value = UserModel.fromJson(value.data()!)},
        );
  }

  Future<String> uploadFileToCloudinary(String imageUrl) async {
    try {
      File imageFile = File(imageUrl);

      // ✅ Check if the file actually exists
      if (!imageFile.existsSync()) {
        print("❌ File does not exist at the given path!");
        isLoading.value = false;
        return "";
      }

      // ✅ Upload image to Cloudinary
      String? uploadedImageUrl = await cloudinaryservice.uploadImage(imageFile);

      if (uploadedImageUrl == null) {
        print("❌ Image upload failed!");
        isLoading.value = false;
        return "";
      }

      print("✅ Profile updated successfully with image: $uploadedImageUrl");
      return uploadedImageUrl;
    } catch (e) {
      print("❌ Error: $e");
    } finally {
      isLoading.value = false;
    }
    return "";
  }

  Future<void> updateProfile(
    String? imageUrl,
    String? name,
    String? about,
    String? number,
  ) async {
    isLoading.value = true;
    try {
      final imageLink = await uploadFileToCloudinary(imageUrl!);
      await getUserDetails();
      final updatedUser = UserModel(
        id: auth.currentUser!.uid,
        email: auth.currentUser!.email,
        name: name,
        about: about,
        profileImage:
            imageUrl == "" ? currentUser.value.profileImage : imageLink,
        phoneNumber: number,
      );

      await db
          .collection("users")
          .doc(auth.currentUser!.uid)
          .set(updatedUser.toJson());
      print("i am user");
    } catch (ex) {
      print(ex);
    }
    isLoading.value = false;
  }
}
