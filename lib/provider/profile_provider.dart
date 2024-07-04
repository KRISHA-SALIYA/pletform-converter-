import 'dart:io';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  File? _image;
  String? _name;
  String? _bio;

  File? get image => _image;
  String? get name => _name;
  String? get bio => _bio;

  void setImage(File? image) {
    _image = image;
    notifyListeners();
  }

  void setName(String? name) {
    _name = name;
    notifyListeners();
  }

  void setBio(String? bio) {
    _bio = bio;
    notifyListeners();
  }
}
