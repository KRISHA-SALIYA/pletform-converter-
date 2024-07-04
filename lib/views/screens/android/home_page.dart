import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pletform_converter_app/views/screens/android/settings_page.dart';

import 'package:provider/provider.dart';

import '../../../provider/platform_provider.dart';
import 'add_contact_page.dart';
import 'chat_page.dart';
import 'contact_list_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController tabBarController;

  @override
  void initState() {
    super.initState();
    tabBarController = TabController(length: 4, vsync: this);
  }

  bool isAndroid = Platform.isAndroid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen.shade500,
        leading: Container(),
        title: Center(
            child: const Text(
          " My Contest",
          style: TextStyle(color: Colors.black),
        )),
        actions: [
          Consumer<PlatformProvider>(
            builder: (context, provider, child) => Transform.scale(
              scale: 0.8,
              child: Switch(
                value: provider.isAndroid,
                onChanged: (val) {
                  provider.changePlatform(value: val);
                },
              ),
            ),
          ),
        ],
        bottom: TabBar(
          controller: tabBarController,
          tabs: const [
            Tab(
              icon: Icon(Icons.add_ic_call_outlined),
            ),
            Tab(
              child: Text("CHATS"),
            ),
            Tab(
              child: Text("CALLS"),
            ),
            Tab(
              child: Text("SETTING"),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabBarController,
        children: [
          const AddContactPage(),
          const ChatContactPage(),
          const ContactListPage(),
          SettingsPage(),
        ],
      ),
    );
  }
}
