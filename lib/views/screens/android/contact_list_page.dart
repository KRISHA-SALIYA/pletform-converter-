import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/global.dart';

class ContactListPage extends StatefulWidget {
  const ContactListPage({Key? key}) : super(key: key);

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: (Global.allContacts.isEmpty)
            ? Container(
                alignment: Alignment.center,
                child: const Text("No any calls yet..."),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: Global.allContacts.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    shadowColor: Colors.indigo,
                    child: ListTile(
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
                      subtitle:
                          Text("+91 ${Global.allContacts[index].phoneNo}"),
                      trailing: IconButton(
                        icon: const Icon(Icons.phone),
                        color: Colors.green,
                        onPressed: () async {
                          Uri call = Uri(
                            scheme: 'tel',
                            path: Global.allContacts[index].phoneNo,
                          );
                          await launchUrl(call);
                        },
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
