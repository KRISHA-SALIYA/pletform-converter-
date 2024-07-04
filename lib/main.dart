import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:pletform_converter_app/provider/add_contact_provider.dart';
import 'package:pletform_converter_app/provider/platform_provider.dart';
import 'package:pletform_converter_app/provider/profile_provider.dart';
import 'package:pletform_converter_app/provider/settings_provider.dart';
import 'package:pletform_converter_app/views/screens/android/home_page.dart';
import 'package:pletform_converter_app/views/screens/ios/ios_home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PlatformProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddContactProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SettingProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<PlatformProvider, SettingProvider>(
      builder: (context, platformProvider, settingProvider, child) {
        return platformProvider.isAndroid
            ? MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: settingProvider.isDark
                    ? ThemeData.dark(useMaterial3: true)
                    : ThemeData.light(useMaterial3: true),
                routes: {
                  '/': (context) => HomePage(),
                },
              )
            : CupertinoApp(
                debugShowCheckedModeBanner: false,
                theme: CupertinoThemeData(
                  brightness: settingProvider.isDark
                      ? Brightness.dark
                      : Brightness.light,
                ),
                routes: {
                  '/': (context) => const IOsHomePage(),
                },
              );
      },
    );
  }
}
