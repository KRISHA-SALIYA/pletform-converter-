import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide TextField;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import '../../../models/contact.dart';
import '../../../models/global.dart';
import '../../../provider/add_contact_provider.dart';
import '../../../provider/settings_provider.dart';

class IOsAddContactPage extends StatefulWidget {
  @override
  State<IOsAddContactPage> createState() => _IOsAddContactPageState();
}

class _IOsAddContactPageState extends State<IOsAddContactPage> {
  GlobalKey<FormState> addContactFormKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  final TextEditingController chatController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  File? image;

  _pickImage_camera() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  _pickImage_gallery() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.height;

    return CupertinoPageScaffold(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoActionSheet(
                          title: const Text("Profile photo"),
                          actions: [
                            CupertinoActionSheetAction(
                              onPressed: _pickImage_camera,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(CupertinoIcons.camera),
                                  SizedBox(width: w * 0.08),
                                  const Text('Camera'),
                                ],
                              ),
                            ),
                            CupertinoActionSheetAction(
                              onPressed: _pickImage_gallery,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(CupertinoIcons
                                      .photo_fill_on_rectangle_fill),
                                  SizedBox(width: w * 0.08),
                                  const Text('Gallery'),
                                ],
                              ),
                            ),
                          ],
                          cancelButton: CupertinoActionSheetAction(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel"),
                          ),
                        );
                      },
                    );
                  },
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: image != null ? FileImage(image!) : null,
                    child: image == null
                        ? const Icon(
                            CupertinoIcons.camera,
                            size: 35,
                          )
                        : null,
                  ),
                ),
              ),
              SizedBox(height: h * 0.02),
              Form(
                key: addContactFormKey,
                child: Consumer<SettingProvider>(
                    builder: (context, settingPro, _) {
                  return Column(
                    children: [
                      CupertinoTextField(
                        controller: fullNameController,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: CupertinoColors.systemGrey,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        textInputAction: TextInputAction.next,
                        prefix: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(CupertinoIcons.person),
                        ),
                        placeholder: 'Full Name',
                      ),
                      SizedBox(height: h * 0.02),
                      CupertinoTextField(
                        maxLength: 10,
                        controller: phoneNoController,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: CupertinoColors.systemGrey,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        prefix: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(CupertinoIcons.phone),
                        ),
                        placeholder: 'Phone Number',
                      ),
                      SizedBox(height: h * 0.02),
                      CupertinoTextField(
                        controller: chatController,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: CupertinoColors.systemGrey,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        textInputAction: TextInputAction.next,
                        prefix: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(CupertinoIcons.chat_bubble),
                        ),
                        placeholder: 'Chat Conversation',
                      ),
                      SizedBox(height: h * 0.02),
                      CupertinoTextField(
                        controller: emailController,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: CupertinoColors.systemGrey,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        prefix: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(CupertinoIcons.mail),
                        ),
                        placeholder: 'Email',
                      ),
                    ],
                  );
                }),
              ),
              SizedBox(height: h * 0.02),
              Consumer<AddContactProvider>(
                builder: (context, provider, child) => Row(
                  children: [
                    GestureDetector(
                        child: Row(
                          children: [
                            SizedBox(width: w * 0.01),
                            const Icon(Icons.calendar_month_outlined),
                            SizedBox(width: w * 0.01),
                            const Text("Pick Date"),
                          ],
                        ),
                        onTap: () {
                          provider.showCupertinoDate(context);
                        }),
                    SizedBox(width: w * 0.08),
                    Text(provider.newCupertinoDate),
                  ],
                ),
              ),
              SizedBox(height: h * 0.02),
              Consumer<AddContactProvider>(
                builder: (context, provider, child) => Row(
                  children: [
                    GestureDetector(
                      child: Row(
                        children: [
                          SizedBox(width: w * 0.01),
                          const Icon(Icons.watch_later_outlined),
                          SizedBox(width: w * 0.01),
                          const Text("Pick Time"),
                        ],
                      ),
                      onTap: () {
                        provider.showCupertinoTime(context);
                      },
                    ),
                    SizedBox(width: w * 0.08),
                    Text(provider.newCupertinoTime),
                  ],
                ),
              ),
              SizedBox(height: h * 0.02),
              CupertinoButton(
                color: CupertinoColors.activeBlue,
                minSize: w * 0.03,
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
                          .newCupertinoDate,
                      time: Provider.of<AddContactProvider>(context,
                              listen: false)
                          .newCupertinoTime,
                    );

                    fullNameController.clear();
                    phoneNoController.clear();
                    chatController.clear();
                    emailController.clear();
                    image = null;
                    Global.allContacts.add(c1);
                    Provider.of<AddContactProvider>(context)
                        .clearDateTimeData();

                    Provider.of<AddContactProvider>(context, listen: false)
                        .hotReload();
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
