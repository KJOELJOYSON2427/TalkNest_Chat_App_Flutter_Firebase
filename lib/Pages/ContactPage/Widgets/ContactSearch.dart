import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactSearch extends StatelessWidget {
  const ContactSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              textInputAction: TextInputAction.done,
              onSubmitted: (value) => {print(value)},
              decoration: InputDecoration(
                hintText: "Search Contact",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.normal, // Thin text
                  fontSize: 16,
                ),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
