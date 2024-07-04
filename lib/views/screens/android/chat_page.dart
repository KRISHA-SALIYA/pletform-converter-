import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/global.dart';

class ChatContactPage extends StatefulWidget {
  const ChatContactPage({Key? key}) : super(key: key);

  @override
  State<ChatContactPage> createState() => _ChatContactPageState();
}

class _ChatContactPageState extends State<ChatContactPage> {
  ImagePicker picker = ImagePicker();

  GlobalKey<FormState> chatEditFormKey = GlobalKey<FormState>();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController chatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: (Global.allContacts.isEmpty)
            ? Container(
                alignment: Alignment.center,
                child: const Text("No any chats yet..."),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: Global.allContacts.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    shadowColor: Colors.indigo,
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed('contact_detail_page',
                                arguments: Global.allContacts[index])
                            .then((value) => setState(() {}));
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => SingleChildScrollView(
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              height: 350,
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text(
                                                'What do you want to take photos from?'),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () async {
                                                  XFile? pickedPhoto =
                                                      await picker.pickImage(
                                                          source: ImageSource
                                                              .gallery);
                                                  setState(() {
                                                    Global.allContacts[index]
                                                            .image =
                                                        File(pickedPhoto!.path);
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("ALBUMS"),
                                              ),
                                              ElevatedButton(
                                                onPressed: () async {
                                                  XFile? pickedFile =
                                                      await picker.pickImage(
                                                          source: ImageSource
                                                              .camera);
                                                  setState(() {
                                                    Global.allContacts[index]
                                                            .image =
                                                        File(pickedFile!.path);
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("CAMERA"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: CircleAvatar(
                                      radius: 50,
                                      foregroundImage: (Global
                                                  .allContacts[index].image !=
                                              null)
                                          ? FileImage(
                                              Global.allContacts[index].image!)
                                          : null,
                                      backgroundColor: Colors.indigo,
                                      child: const Icon(
                                        Icons.camera_alt_outlined,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01),
                                  Form(
                                    key: chatEditFormKey,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01),
                                        TextFormField(
                                          controller: fullNameController,
                                          textInputAction: TextInputAction.next,
                                          keyboardType: TextInputType.text,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Full Name",
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01),
                                        TextFormField(
                                          controller: chatController,
                                          textInputAction: TextInputAction.next,
                                          keyboardType: TextInputType.text,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Chat",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.edit),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.delete),
                                      ),
                                    ],
                                  ),
                                  Center(
                                    child: CupertinoButton(
                                      color: Colors.indigo,
                                      onPressed: () {},
                                      child: const Text("CANCEL"),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      leading: CircleAvatar(
                        radius: 30,
                        foregroundImage:
                            (Global.allContacts[index].image != null)
                                ? FileImage(Global.allContacts[index].image!)
                                : null,
                        child: Text(
                          Global.allContacts[index].fullName![0].toUpperCase(),
                        ),
                      ),
                      title: Text("${Global.allContacts[index].fullName}"),
                      subtitle: Text("${Global.allContacts[index].chat}"),
                      trailing: Text(
                          "${Global.allContacts[index].date}, ${Global.allContacts[index].time}"),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
