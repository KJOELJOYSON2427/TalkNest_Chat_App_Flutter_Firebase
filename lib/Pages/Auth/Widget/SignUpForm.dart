import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/Controller/AuthController.dart';

import 'package:my_project/Widgets/PrimaryButton.dart';

class Signupform extends StatelessWidget {
  const Signupform({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController name = TextEditingController();

    Authcontroller authcontroller = Get.put(Authcontroller());
    return Column(
      children: [
        SizedBox(height: 40),
        TextField(
          controller: name,
          decoration: InputDecoration(
            hintText: "Full Name",
            prefixIcon: Icon(Icons.person),
          ),
        ),
        SizedBox(height: 30),
        TextField(
          controller: email,
          decoration: InputDecoration(
            hintText: "Email",
            prefixIcon: Icon(Icons.alternate_email_sharp),
          ),
        ),
        SizedBox(height: 30),
        TextField(
          controller: password,
          decoration: InputDecoration(
            hintText: "Password",
            prefixIcon: Icon(Icons.password_outlined),
          ),
        ),
        SizedBox(height: 80),
        Obx(
          () =>
              authcontroller.isLoading.value
                  ? CircularProgressIndicator()
                  : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Primarybutton(
                        btnName: "SIGNUP",
                        icon: Icons.person_add,
                        onTap: () {
                          authcontroller.createUser(
                            email.text,
                            password.text,
                            name.text,
                          );
                          // Get.offAllNamed("/homePage");
                        },
                      ),
                    ],
                  ),
        ),
      ],
    );
  }
}
