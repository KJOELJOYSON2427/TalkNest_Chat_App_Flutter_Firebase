import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:my_project/Pages/Auth/Widget/LoginForm.dart';
import 'package:my_project/Pages/Auth/Widget/SignUpForm.dart';

class Authpagebody extends StatelessWidget {
  const Authpagebody({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isLogin = true.obs;
    return Container(
      padding: const EdgeInsets.all(20),
      // height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(

                        splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
                        onTap: () {
                          isLogin.value = true;
                        },
                        child: Container(
                          width: MediaQuery.sizeOf(context).width / 2.7,
                          child: Column(
                            children: [
                              Text(
                                "Login",
                                style:
                                    isLogin.value
                                        ? Theme.of(context).textTheme.bodyLarge
                                        : Theme.of(
                                          context,
                                        ).textTheme.labelLarge,
                              ),
                              SizedBox(height: 5),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 200),
                                width: isLogin.value ? 150 : 0,
                                height: 3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
                        onTap: () {
                          isLogin.value = false;
                        },
                        child: Container(
                          width: MediaQuery.sizeOf(context).width / 2.7,
                          child: Column(
                            children: [
                              Text(
                                "Signup",
                                style:
                                    isLogin.value
                                        ? Theme.of(context).textTheme.labelLarge
                                        : Theme.of(context).textTheme.bodyLarge,
                              ),
                              SizedBox(height: 5),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 200),
                                width: isLogin.value ? 0 : 150,
                                height: 3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(() => isLogin.value ? LoginForm() : Signupform()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
