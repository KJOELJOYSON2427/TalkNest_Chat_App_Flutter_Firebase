import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_project/Config/Strings.dart';
import 'package:my_project/Config/images.dart';
import 'package:my_project/Pages/Welcome/widget/WelcomeBody.dart';
import 'package:my_project/Pages/Welcome/widget/WelcomeFooterButton.dart';

import 'package:my_project/Pages/Welcome/widget/WelcomeHeading.dart';
import 'package:slide_to_act/slide_to_act.dart';

class Welcomepage extends StatelessWidget {
  const Welcomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10), // ✅ Added missing comma
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [WelcomeHeading(), Welcomebody(), Welcomefooterbutton()],
          ),
        ),
      ),
    );
  }
}
