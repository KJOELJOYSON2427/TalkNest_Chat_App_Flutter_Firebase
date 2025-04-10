import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_project/Widgets/PrimaryButton.dart';

class UserUpdateProfile extends StatelessWidget {
  const UserUpdateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Profile")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.all(8),
                            width: 200,
                            height: 200,
                            child: Center(child: Icon(Icons.image, size: 40)),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Text(
                                "Personal Info",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Text(
                                "Name",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          TextField(
                            decoration: InputDecoration(
                              hintText: "Nitish Kumar",
                              hintStyle: TextStyle(
                                fontSize: 14, // Smaller text
                                fontWeight:
                                    FontWeight.w300, // Light font weight
                                color:
                                    Colors.grey, // Optional: Light gray color
                              ),
                              prefixIcon: Icon(Icons.person),
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Text(
                                "Email id",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          TextField(
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: "Nitesh@gmail.com",
                              hintStyle: TextStyle(
                                fontSize: 14, // Smaller text
                                fontWeight:
                                    FontWeight.w300, // Light font weight
                                color:
                                    Colors.grey, // Optional: Light gray color
                              ),
                              prefixIcon: Icon(Icons.alternate_email_rounded),
                            ),
                          ),

                          SizedBox(height: 20),
                          Row(
                            children: [
                              Text(
                                "Phone Number",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          TextField(
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: "+91 98765 43210",
                              hintStyle: TextStyle(
                                fontSize: 14, // Smaller text
                                fontWeight:
                                    FontWeight.w300, // Light font weight
                                color:
                                    Colors.grey, // Optional: Light gray color
                              ),
                              prefixIcon: Icon(Icons.phone),
                            ),
                          ),
                          SizedBox(height: 20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Primarybutton(
                                btnName: "Save",
                                icon: Icons.save,
                                onTap: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
