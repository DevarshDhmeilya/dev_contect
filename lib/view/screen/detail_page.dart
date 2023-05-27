import 'dart:io';

import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import '../../model/contact.dart';
import '../../model/global.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    Contact data = ModalRoute.of(context)!.settings.arguments as Contact;
    int index = Global.allContacts.indexOf(data);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: (isDark != false) ? Colors.white : Colors.black,
        backgroundColor: (isDark == false) ? Colors.white : Colors.black,
        centerTitle: true,
        title: const Text("Detail Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Spacer(flex: 9),
                  CircleAvatar(
                    radius: 60,
                    child: Text("${data.firstName![0].toUpperCase()}"),
                    foregroundImage: (Global.allContacts[index].img != null)
                        ? FileImage(
                            File(Global.allContacts[index].img as String))
                        : null,
                  ),
                  const Spacer(flex: 2),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        Global.allContacts.remove(data);
                      });
                    },
                    icon: const Icon(Icons.delete),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () async {
                      await Navigator.of(context)
                          .pushNamed('edit_contact_page',
                              arguments: Global.allContacts.indexOf(data))
                          .then((value) => setState(() {}));
                    },
                    icon: const Icon(Icons.edit),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text("${data.firstName} ${data.lastName}"),
              const SizedBox(height: 14),
              SelectableText(
                "+91 ${data.phoneNo}",
                toolbarOptions: ToolbarOptions(
                  copy: true,
                  selectAll: true,
                  cut: false,
                  paste: false,
                ),
              ),
              const SizedBox(height: 14),
              const Divider(thickness: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                      backgroundColor: Colors.green,
                      child: Icon(
                        Icons.call,
                      ),
                      onPressed: () async {
                        Uri call = Uri(scheme: 'tel', path: data.phoneNo);
                        await launchUrl(call);
                      }),
                  FloatingActionButton(
                    backgroundColor: Colors.amber,
                    child: Icon(Icons.sms),
                    onPressed: () async {
                      Uri sms = Uri(scheme: 'sms', path: data.phoneNo);
                      await launchUrl(sms);
                    },
                  ),
                  FloatingActionButton(
                      backgroundColor: Colors.cyan,
                      child: Icon(Icons.email),
                      onPressed: () async {
                        Uri email = Uri(
                          scheme: 'mailto',
                          path: data.email,
                          query:
                              "subject=Demo mail&body=This is Demo mail from Flutter.",
                        );
                        await launchUrl(email);
                      }),
                  FloatingActionButton(
                      backgroundColor: Colors.brown,
                      child: Icon(Icons.share),
                      onPressed: () async {
                        await Share.share(
                            "Name : ${data.firstName} ${data.lastName}\nContact : ${data.phoneNo}");
                      }),
                ],
              ),
              const Divider(thickness: 3),
              const Spacer(flex: 4),
            ],
          ),
        ),
      ),
    );
  }
}
