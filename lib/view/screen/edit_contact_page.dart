import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../main.dart';

import '../../model/global.dart';

class EditContactPage extends StatefulWidget {
  const EditContactPage({Key? key}) : super(key: key);

  @override
  State<EditContactPage> createState() => _EditContactPageState();
}

class _EditContactPageState extends State<EditContactPage> {
  GlobalKey<FormState> editContacteFormKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    int index = ModalRoute.of(context)!.settings.arguments as int;

    firstNameController.text = (Global.allContacts[index].firstName != null)
        ? Global.allContacts[index].firstName as String
        : "";
    lastNameController.text = (Global.allContacts[index].lastName != null)
        ? Global.allContacts[index].lastName as String
        : "";
    phoneNoController.text = (Global.allContacts[index].phoneNo != null)
        ? Global.allContacts[index].phoneNo as String
        : "";
    emailController.text = (Global.allContacts[index].email != null)
        ? Global.allContacts[index].email as String
        : "";

    return Scaffold(
      appBar: AppBar(
        foregroundColor: (isDark != false) ? Colors.white : Colors.black,
        backgroundColor: (isDark == false) ? Colors.white : Colors.black,
        title: Text("Edit Contact"),
        actions: [
          IconButton(
            onPressed: () {
              if (editContacteFormKey.currentState!.validate()) {
                editContacteFormKey.currentState!.save();

                Global.allContacts[index].firstName = firstNameController.text;
                Global.allContacts[index].lastName = lastNameController.text;
                Global.allContacts[index].phoneNo = phoneNoController.text;
                Global.allContacts[index].email = emailController.text;

                Navigator.of(context).pop();
              }
            },
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Center(
                  child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    foregroundImage: (Global.allContacts[index].img != null)
                        ? FileImage(
                            File(Global.allContacts[index].img as String))
                        : null,
                    radius: 60,
                    child: Text(
                      "Edit",
                      style: TextStyle(fontSize: 25, color: Colors.black),
                    ),
                  ),
                  FloatingActionButton(
                      child: Icon(Icons.add),
                      mini: true,
                      onPressed: () async {
                        XFile? tImage =
                            await picker.pickImage(source: ImageSource.camera);
                        setState(() {
                          Global.allContacts[index].img = tImage?.path;
                        });
                        // Navigator.of(context).pop();
                      })
                ],
              )),
              SizedBox(height: 30),
              Form(
                key: editContacteFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("First name"),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: firstNameController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      // initialValue: Global.firstName,

                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "First name",
                      ),
                    ),
                    SizedBox(height: 20),
                    Text("Last name"),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: lastNameController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      // initialValue: Global.lastName,

                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Last name",
                      ),
                    ),
                    SizedBox(height: 20),
                    Text("Phone number"),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: phoneNoController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      // initialValue: Global.phoneNo,

                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "+91 0000000000",
                      ),
                    ),
                    SizedBox(height: 20),
                    Text("Email"),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: emailController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.emailAddress,
                      // initialValue: Global.email,

                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Email",
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
