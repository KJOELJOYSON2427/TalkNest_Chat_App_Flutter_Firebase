import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_project/Config/Strings.dart';
import 'package:my_project/Config/images.dart';
import 'package:my_project/Controller/ContactController.dart';
import 'package:my_project/Controller/ImagePicker.dart';
import 'package:my_project/Controller/Profileontroller.dart';
import 'package:my_project/Controller/statusController.dart';
import 'package:my_project/Pages/CallHistory/CallHistoty.dart';
import 'package:my_project/Pages/Groups/NewGroup/GroupPage.dart';
import 'package:my_project/Pages/HomePage/Widget/ChatsList.dart';
import 'package:my_project/Pages/HomePage/Widget/TabBar.dart';
import 'package:my_project/Pages/ProfilePage/ProfilePage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    Contactcontroller contactcontroller = Get.put(Contactcontroller());
    ProfileController profileController = Get.put(ProfileController());
    ImagePickerController imagePickerController = Get.put(
      ImagePickerController(),
    );
    _tabController = TabController(length: 3, vsync: this);

    Statuscontroller statuscontroller = Get.put(Statuscontroller());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(
          AppString.appName,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(AssestsImage.appIcon, width: 10),
        ),
        actions: [
          IconButton(
            onPressed: () {
              contactcontroller.getChatRoomList();
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              // Get.toNamed("/profilePage");
              Get.to(Profilepage());
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
        bottom: myTabBar(_tabController, context),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed("/contactPage");
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TabBarView(
          controller: _tabController,
          children: [
            ChatList(),

            GroupPage(),
           CallHistory()
          ],
        ),
      ),
    );
  }
}
