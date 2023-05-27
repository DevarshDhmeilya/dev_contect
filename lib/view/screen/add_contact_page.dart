import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../main.dart';
import '../../model/contact.dart';
import '../../model/global.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({Key? key}) : super(key: key);

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final ImagePicker picker = ImagePicker();
  String? image;

  GlobalKey<FormState> addContactFormKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   firstNameController.text = (Global.firstName != null) ? Global.firstName as String : "";
  //   lastNameController.text = (Global.lastName != null) ? Global.lastName as String : "";
  //   phoneNoController.text = (Global.phoneNo != null) ? Global.phoneNo as String : "";
  //   emailController.text = (Global.email != null) ? Global.email as String : "";
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add"),
        backgroundColor: (isDark == false) ? Colors.white : Colors.black,
        foregroundColor: (isDark != false) ? Colors.white : Colors.black,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                if (addContactFormKey.currentState!.validate()) {
                  Contact c1 = Contact(
                    firstName: firstNameController.text,
                    lastName: lastNameController.text,
                    phoneNo: phoneNoController.text,
                    email: emailController.text,
                    img: image,
                  );

                  firstNameController.clear();
                  lastNameController.clear();
                  phoneNoController.clear();
                  emailController.clear();

                  Global.allContacts.add(c1);
                  Navigator.of(context).pop();
                }
              },
              icon: const Icon(Icons.check))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    foregroundImage: (image != null)
                        ? FileImage(File(image as String))
                        : null,
                    backgroundColor: Colors.grey,
                    radius: 60,
                    child: const Text("ADD"),
                  ),
                  FloatingActionButton(
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                                'What do you want to take photos from?'),
                            actions: [
                              ElevatedButton(
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  XFile? pickedPhoto = await picker.pickImage(
                                      source: ImageSource.gallery);
                                  setState(() {
                                    image = pickedPhoto!.path;
                                  });
                                },
                                child: const Text("ALBUMS"),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  XFile? pickedFile = await picker.pickImage(
                                      source: ImageSource.camera);
                                  setState(() {
                                    image = pickedFile!.path;
                                  });
                                },
                                child: const Text("CAMERA"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    mini: true,
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Form(
                key: addContactFormKey,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "First Name",
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: firstNameController,
                          textInputAction: TextInputAction.next,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter Your First Name...";
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(),
                              hintText: "First Name"),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Last Name",
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: lastNameController,
                          textInputAction: TextInputAction.next,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter Your Last Name...";
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(),
                              hintText: "Last Name"),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Phone Number",
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: phoneNoController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.phone,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter Your Phone Number...";
                            } else if (val.length != 10) {
                              return "Enter 10 Digits Phone Number...";
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(),
                              hintText: "+91 0000000000"),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Email",
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: emailController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter Your Email...";
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(),
                            hintText: "Email",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
