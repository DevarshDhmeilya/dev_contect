import 'dart:io';
import 'package:dev_contect/view/screen/add_contact_page.dart';
import 'package:dev_contect/view/screen/detail_page.dart';
import 'package:dev_contect/view/screen/edit_contact_page.dart';
import 'package:dev_contect/view/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'model/global.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarDividerColor: Colors.red,
      statusBarColor: Colors.amber,
      systemNavigationBarColor: Colors.blueAccent,
    ),
  );
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    const MyApp(),
  );
}

bool isDark = false;
bool isGridView = false;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: (isDark == false) ? ThemeMode.light : ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      initialRoute: 'splash_screen',
      routes: {
        'add_contact_page': (context) => const AddContactPage(),
        'splash_screen': (context) => const SplashScreen(),
        'detail_page': (context) => const DetailPage(),
        'edit_contact_page': (context) => const EditContactPage(),
        '/': (context) => Scaffold(
              appBar: AppBar(
                title: const Text("Contact"),
                backgroundColor: (isDark == false) ? Colors.white : Colors.black,
                foregroundColor: (isDark != false) ? Colors.white : Colors.black,
                elevation: 0,
                actions: [
                  IconButton(
                      onPressed: () {
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.refresh,
                      )),
                  IconButton(
                    icon: Icon(Icons.circle),
                    onPressed: () {
                      setState(() {
                        isDark = !isDark;
                      });
                    },
                  ),
                  IconButton(
                    icon: (isGridView == false) ? Icon(Icons.more_vert) : Icon(Icons.menu),
                    onPressed: () {
                      setState(() {
                        isGridView = !isGridView;
                      });
                    },
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  await Navigator.of(context).pushNamed('add_contact_page').then((value) => setState(() {}));
                },
                child: Icon(Icons.add),
              ),
              body: Container(
                alignment: Alignment.center,
                child: (Global.allContacts.isEmpty)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assetes/images/build/open-cardboard-box.jpg",
                            width: 120,
                            color: Colors.grey,
                          ),
                          Text(
                            "You have no yet contacts",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      )
                    : (isGridView == true)
                        ? GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              crossAxisCount: 2,
                            ),
                            itemCount: Global.allContacts.length,
                            itemBuilder: (context, i) {
                              return Card(
                                elevation: 3,
                                shadowColor: Colors.blue,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed('detail_page', arguments: Global.allContacts[i]);
                                  },
                                  child: Container(
                                    height: 200,
                                    alignment: Alignment.center,
                                    color: Colors.blue,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        CircleAvatar(
                                          radius: 60,
                                          foregroundImage: (Global.allContacts[i].img != null)
                                              ? FileImage(File(Global.allContacts[i].img as String))
                                              : null,
                                        ),
                                        Text("${Global.allContacts[i].firstName} ${Global.allContacts[i].lastName}")
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : ListView.builder(
                            itemCount: Global.allContacts.length,
                            itemBuilder: (context, i) {
                              return Card(
                                elevation: 3,
                                shadowColor: Colors.blue,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed('detail_page', arguments: Global.allContacts[i])
                                        .then((value) => setState(() {}));
                                  },
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.amber,
                                    foregroundImage:
                                        (Global.allContacts[i].img != null) ? FileImage(File(Global.allContacts[i].img as String)) : null,
                                  ),
                                  title: Text("${Global.allContacts[i].firstName} ${Global.allContacts[i].lastName}"),
                                  subtitle: Text("+91 ${Global.allContacts[i].phoneNo}"),
                                  trailing: IconButton(
                                      icon: const Icon(Icons.phone),
                                      color: Colors.green,
                                      onPressed: () async {
                                        Uri call = Uri(scheme: 'tel', path: "+91${Global.allContacts[i].phoneNo}");
                                        await launchUrl(call);
                                      }),
                                ),
                              );
                            },
                          ),
              ),
            ),
      },
    );
  }
}
