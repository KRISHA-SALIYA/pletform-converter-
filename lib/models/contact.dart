import 'dart:io';

class Contact {
  String? fullName;
  String? phoneNo;
  String? chat;
  String? email;
  File? image;
  String? date;
  String? time;


  Contact({
    required this.fullName,
    required this.phoneNo,
    required this.chat,
    required this.email,
    this.image,
    required this.date,
    required this.time,
  });

}