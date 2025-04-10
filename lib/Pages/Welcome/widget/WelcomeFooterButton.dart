import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_project/Config/Strings.dart';
import 'package:my_project/Config/images.dart';
import 'package:slide_to_act/slide_to_act.dart';

class Welcomefooterbutton extends StatelessWidget {
  const Welcomefooterbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return SlideAction(
      onSubmit: () {
        Get.offAllNamed("/authPage");
      },
      sliderButtonIcon: SvgPicture.asset(AssestsImage.plugSVG, width: 25),
      sliderRotate: true,
      submittedIcon: Container(
        height: 30,
        width: 25,

        child: SvgPicture.asset(AssestsImage.plugSVG, width: 25),
      ),
      innerColor: Theme.of(context).colorScheme.primary,
      outerColor: Theme.of(context).colorScheme.primaryContainer,
      text: WelcomePageString.slideToStart,
      textStyle: Theme.of(context).textTheme.labelLarge,
    );
  }
}
