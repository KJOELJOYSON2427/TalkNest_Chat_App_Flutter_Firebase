import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_project/Config/Strings.dart';
import 'package:my_project/Config/images.dart';

class WelcomeHeading extends StatelessWidget {
  const WelcomeHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ✅ Fixed missing `children` in Row
            Column(
              children: [
                SvgPicture.asset(
                  AssestsImage.appIcon,

                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20),
        Text(
          AppString.appName,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ],
    );
  }
}
