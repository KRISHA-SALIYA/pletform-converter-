import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/global.dart';

class IOsContactListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: (Global.allContacts.isEmpty)
            ? Container(
                alignment: Alignment.center,
                child: const Text("No any calls yet..."),
              )
            : ListView.builder(
                itemCount: Global.allContacts.length,
                itemBuilder: (context, index) {
                  return CupertinoListTile(
                    leading: CircleAvatar(
                      radius: 35,
                      backgroundImage: Global.allContacts[index].image != null
                          ? FileImage(Global.allContacts[index].image!)
                          : null,
                      child: Global.allContacts[index].image == null
                          ? const Icon(CupertinoIcons.person)
                          : null,
                    ),
                    title: Text(Global.allContacts[index].fullName!),
                    subtitle: Text(Global.allContacts[index].phoneNo!),
                    trailing: CupertinoButton(
                      onPressed: () async {
                        Uri call = Uri(
                          scheme: 'tel',
                          path: Global.allContacts[index].phoneNo,
                        );
                        await launchUrl(call);
                      },
                      child: const Icon(CupertinoIcons.phone),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
