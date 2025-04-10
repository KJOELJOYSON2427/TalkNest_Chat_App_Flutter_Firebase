import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewcontactTile extends StatelessWidget {
  final String btnName;
  final IconData icon;
  final VoidCallback onTap;
  const NewcontactTile({
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
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,

              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Icon(icon),
            ),
            SizedBox(width: 10),
            Text(btnName),
          ],
        ),
      ),
    );
  }
}
