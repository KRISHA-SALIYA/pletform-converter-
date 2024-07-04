import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../models/contact.dart';
import '../../../models/global.dart';
import '../../../provider/add_contact_provider.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({Key? key}) : super(key: key);

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final ImagePicker picker = ImagePicker();
  File? image;

  GlobalKey<FormState> addContactFormKey = GlobalKey<FormState>();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController chatController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String pickedDate = "";
  String pickedTime = "";

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h * 0.04),
              Center(
                child: GestureDetector(
                  onTap: () => showImageBottomSheet(context),
                  child: CircleAvatar(
                    foregroundImage: (image != null) ? FileImage(image!) : null,
                    backgroundColor: Colors.lightGreen.shade300,
                    radius: 60,
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: h * 0.04),
              Form(
                key: addContactFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: h * 0.02),
                    const Text("Full Name"),
                    SizedBox(height: h * 0.01),
                    TextFormField(
                      controller: fullNameController,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Your Name First...";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.account_circle_outlined),
                        hintText: "Full Name",
                      ),
                    ),
                    SizedBox(height: h * 0.02),
                    const Text("Phone No."),
                    SizedBox(height: h * 0.01),
                    TextFormField(
                      controller: phoneNoController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Your Phone Number...";
                        } else if (value.length != 10) {
                          return "Enter 10 Digits Phone Number...";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.call),
                        hintText: "Phone No.",
                      ),
                    ),
                    SizedBox(height: h * 0.02),
                    const Text("Chat Conversation"),
                    SizedBox(height: h * 0.01),
                    TextFormField(
                      controller: chatController,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.chat_outlined),
                        hintText: "Chat Conversation",
                      ),
                    ),
                    SizedBox(height: h * 0.02),
                    const Text("Email I'd"),
                    SizedBox(height: h * 0.01),
                    TextFormField(
                      controller: emailController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Your Email I'd...";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                        hintText: "Email",
                      ),
                    ),
                    SizedBox(height: h * 0.02),
                    Consumer<AddContactProvider>(
                      builder: (context, provider, child) => Row(
                        children: [
                          GestureDetector(
                              child: const Row(
                                children: [
                                  Icon(Icons.calendar_month_outlined),
                                  Text("Pick Date"),
                                ],
                              ),
                              onTap: () {
                                provider.showMyDate(context);
                              }),
                          SizedBox(width: w * 0.08),
                          Text(provider.date),
                        ],
                      ),
                    ),
                    SizedBox(height: h * 0.02),
                    Consumer<AddContactProvider>(
                      builder: (context, provider, child) => Row(
                        children: [
                          GestureDetector(
                            child: const Row(
                              children: [
                                Icon(Icons.watch_later_outlined),
                                Text("Pick Time"),
                              ],
                            ),
                            onTap: () {
                              provider.showMaterialTime(context);
                            },
                          ),
                          SizedBox(width: w * 0.08),
                          Text(provider.time),
                        ],
                      ),
                    ),
                    SizedBox(height: h * 0.02),
                    Center(
                      child: OutlinedButton(
                        onPressed: () {
                          if (addContactFormKey.currentState!.validate()) {
                            addContactFormKey.currentState!.save();

                            Contact c1 = Contact(
                              fullName: fullNameController.text,
                              phoneNo: phoneNoController.text,
                              chat: chatController.text,
                              email: emailController.text,
                              image: image,
                              date: Provider.of<AddContactProvider>(context,
                                      listen: false)
                                  .date,
                              time: Provider.of<AddContactProvider>(context,
                                      listen: false)
                                  .time,
                            );

                            fullNameController.clear();
                            phoneNoController.clear();
                            chatController.clear();
                            emailController.clear();
                            Provider.of<AddContactProvider>(context,
                                    listen: false)
                                .date = "";
                            Provider.of<AddContactProvider>(context,
                                    listen: false)
                                .time = "";
                            Global.allContacts.add(c1);

                            Provider.of<AddContactProvider>(context,
                                    listen: false)
                                .hotReload();
                          }
                        },
                        child: const Text("SAVE"),
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

  _pickImage_camera() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
  }

  _pickImage_gallery() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
  }

  showImageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(18),
          height: 170,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Profile photo"),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 65,
                        child: ElevatedButton(
                            onPressed: _pickImage_camera,
                            child: const Icon(
                              Icons.camera_alt,
                              size: 35,
                            )),
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      const Text("Camera"),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 65,
                        child: ElevatedButton(
                          onPressed: _pickImage_gallery,
                          child: const Icon(
                            Icons.photo_library,
                            size: 35,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      const Text("Gallery"),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
