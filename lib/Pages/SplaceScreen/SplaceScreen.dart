import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_project/Config/images.dart';
import 'package:my_project/Controller/SplaceController.dart';

class Splacescreen extends StatelessWidget {
  const Splacescreen({super.key});

  @override
  Widget build(BuildContext context) {
    Splacecontroller splacecontroller = Get.put(Splacecontroller());
    return Scaffold(
      body: Center(child: SvgPicture.asset(AssestsImage.appIcon)),
    );
  }
}
