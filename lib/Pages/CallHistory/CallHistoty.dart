import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/utils.dart';
import 'package:my_project/Config/images.dart';
import 'package:my_project/Controller/ChatContoller.dart';
import 'package:my_project/Pages/HomePage/ChatTitle.dart';

class CallHistory extends StatelessWidget {
  const CallHistory({super.key});

  @override
  Widget build(BuildContext context) {
    Chatcontoller chatController = Get.put(Chatcontoller());

    return StreamBuilder(
      stream: chatController.getCalls(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final call = snapshot.data![index];

              return ChatTitle(
                imageUrl: call.callerPic ?? AssestsImage.defaultProfileUrl,
                name: call.callerName ?? "...",
                lastChat: call.time ?? "Recently called",
                lastTime:
                    call.timestamp ?? "", // Add appropriate field if needed
              );
            },
          );
        } else {
          return Center(
            child: Container(
              width: 200,
              height: 200,
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
