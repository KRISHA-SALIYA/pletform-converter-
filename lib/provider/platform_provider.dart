import 'package:flutter/widgets.dart';

class PlatformProvider extends ChangeNotifier {
  bool isAndroid = true;

  void changePlatform({required bool value}) {
    isAndroid = value;
    notifyListeners();
  }
}
