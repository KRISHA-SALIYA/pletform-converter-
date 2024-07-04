import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pletform_converter_app/provider/profile_provider.dart';
import 'package:pletform_converter_app/provider/settings_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  final GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<SettingProvider, ProfileProvider>(
        builder: (context, settingProvider, profileProvider, child) =>
            SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
                title: const Text("Profile"),
                subtitle: const Text("Update Profile Data"),
                trailing: Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: settingProvider.isSwitched,
                    onChanged: (value) => settingProvider.isSwitched = value,
                  ),
                ),
              ),
              if (settingProvider.isSwitched)
                Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Profile photo",
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              height: 65,
                                              child: ElevatedButton(
                                                  child: const Icon(
                                                    Icons.camera_alt,
                                                    size: 35,
                                                  ),
                                                  // title: Text('Camera'),
                                                  onPressed: () async {
                                                    final pickedPhoto =
                                                        await picker.pickImage(
                                                      source:
                                                          ImageSource.camera,
                                                    );
                                                    if (pickedPhoto != null) {
                                                      profileProvider.setImage(
                                                          File(pickedPhoto
                                                              .path));
                                                    }
                                                    Navigator.of(context).pop();
                                                  }),
                                            ),
                                            const SizedBox(
                                              height: 9,
                                            ),
                                            const Text(
                                              "Camera",
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 65,
                                              child: ElevatedButton(
                                                  child: const Icon(
                                                    Icons.photo_library,
                                                    size: 35,
                                                  ),
                                                  // title: Text('Gallery'),
                                                  onPressed: () async {
                                                    final pickedPhoto =
                                                        await picker.pickImage(
                                                      source:
                                                          ImageSource.gallery,
                                                    );
                                                    if (pickedPhoto != null) {
                                                      profileProvider.setImage(
                                                          File(pickedPhoto
                                                              .path));
                                                    }
                                                    Navigator.of(context).pop();
                                                  }),
                                            ),
                                            const SizedBox(
                                              height: 9,
                                            ),
                                            const Text(
                                              "Gallery",
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.lightGreen,
                          radius: 50,
                          foregroundImage: profileProvider.image != null
                              ? FileImage(profileProvider.image!)
                              : null,
                          child: const Icon(
                            Icons.add_a_photo_outlined,
                            size: 30,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Form(
                        key: profileFormKey,
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 118.0),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: nameController,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter Your Name First...";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter your name...",
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: bioController,
                                textInputAction: TextInputAction.done,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter your bio...",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (profileFormKey.currentState!.validate()) {
                                profileFormKey.currentState!.save();
                                profileProvider.setName(nameController.text);
                                profileProvider.setBio(bioController.text);
                              }
                            },
                            child: const Text(
                              "SAVE",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              profileProvider.setName(null);
                              profileProvider.setBio(null);
                              nameController.clear();
                              bioController.clear();
                              profileProvider.setImage(null);
                            },
                            child: const Text(
                              "CLEAR",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                )
              else
                Container(),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.sunny,
                  color: Colors.grey,
                ),
                title: const Text("Theme"),
                subtitle: const Text("Change Theme"),
                trailing: Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: settingProvider.isDark,
                    onChanged: (value) => settingProvider.isDark = value,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
