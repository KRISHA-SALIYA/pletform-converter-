import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../provider/platform_provider.dart';
import 'ios_add_contact_page.dart';
import 'ios_chat_Page.dart';
import 'ios_contact_list_page.dart';
import 'ios_setting_page.dart';

class IOsHomePage extends StatefulWidget {
  const IOsHomePage({Key? key}) : super(key: key);

  @override
  _IOsHomePageState createState() => _IOsHomePageState();
}

class _IOsHomePageState extends State<IOsHomePage> {
  final List<Widget> _myPages = [
    IOsAddContactPage(),
    IOsChatPage(),
    IOsContactListPage(),
    IOsSettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("PlatForm Convertor App"),
        trailing:
            Consumer<PlatformProvider>(builder: (context, provider, widget) {
          return Transform.scale(
            scale: 0.8,
            child: CupertinoSwitch(
              value: provider.isAndroid,
              onChanged: (val) => provider.changePlatform(value: val),
            ),
          );
        }),
      ),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_add),
              label: 'ADD CONTACT',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chat_bubble_2),
              label: 'CHATS',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.phone),
              label: 'CALLS',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.settings),
              label: 'SETTINGS',
            ),
          ],
        ),
        tabBuilder: (BuildContext context, int index) {
          return CupertinoTabView(
            builder: (BuildContext context) {
              return _myPages[index];
            },
          );
        },
      ),
    );
  }
}
