import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/Controller/AuthController.dart';
import 'package:my_project/Widgets/PrimaryButton.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    Authcontroller authcontroller = Get.put(Authcontroller());

    return Column(
      children: [
        SizedBox(height: 40),
        TextField(
          controller: email,
          decoration: InputDecoration(
            hintText: "Email",
            prefixIcon: Icon(Icons.alternate_email_outlined),
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
                        btnName: "LOGIN",
                        icon: Icons.lock_open_outlined,
                        onTap: () {
                          authcontroller.login(email.text, password.text);
                        },
                      ),
                    ],
                  ),
        ),
      ],
    );
  }
}
