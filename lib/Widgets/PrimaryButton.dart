import 'package:flutter/material.dart';

class Primarybutton extends StatelessWidget {
  final String btnName;
  final IconData icon;
  final VoidCallback onTap;
  const Primarybutton({
    super.key,
    required this.btnName,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            SizedBox(width: 10),

            Text(btnName, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}
