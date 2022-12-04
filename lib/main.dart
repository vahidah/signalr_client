import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:provider/provider.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/dependency_injection.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'screens/chat/chat_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runZonedGuarded(
      () => runApp(
            MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => getIt<ChatState>()),
              ],
              child: const MyApp(),
            ),
          ), (error, stack) {
    debugPrint("we have error");
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "simple chat app",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final TextEditingController _controllerId = TextEditingController();
  final TextEditingController _controllerMessage = TextEditingController();
  final TextEditingController _controllerJoinGroup = TextEditingController();
  final TextEditingController _controllerGroupSendMessage = TextEditingController();
  final TextEditingController _controllerGroupNameSendMessage = TextEditingController();

  String? firebaseToken;

  bool tokenSend = false;

  final connection = HubConnectionBuilder()
      .withUrl(
          'http://10.0.2.2:5000/Myhub',
          HttpConnectionOptions(
            client: IOClient(HttpClient()..badCertificateCallback = (x, y, z) => true),
            logging: (level, message) => print(message),
          ))
      .build();

  int? myId;

  void _initializeSignalRConnection() async {
    await connection.start();
  }

  final FirebaseMessaging _firebasemessaging = FirebaseMessaging.instance;

  _getToken() {
    print('here1');
    _firebasemessaging.getToken().then((deviceToken) {
      print("Device Token: $deviceToken");
      firebaseToken = deviceToken;
      if (mounted) {
        setState(() {});
      }
    });
  }

  final List<Tab> tabs = <Tab>[
    const Tab(
      icon: Icon(Icons.person),
      text: "Private Chat",
    ),
    const Tab(
      icon: Icon(Icons.group),
      text: "Groups",
    ),
    const Tab(icon: Icon(Icons.send), text: "Send Message")
  ];
  late TabController tabController;

  Map<int, List<Map<int, String>>> contacts = <int, List<Map<int, String>>>{};
  Map<String, List<Map<int, String>>> groups = <String, List<Map<int, String>>>{};

  int selectedChat = -1;
  String selectedGroup = "none";

  @override
  initState() {
    // TODO: implement initState
    super.initState();

    _initializeSignalRConnection();

    _getToken();

    connection.on('ReceiveNewMessage', (message) {
      if (contacts.containsKey(message![0])) {
        // it cant be null we check it above
        contacts[message[0]]?.add({message[0]: message[1]});
      } else {
        contacts[message[0]] = [
          {message[0]: message[1]}
        ];
      }
      setState(() {});
      debugPrint("new message received from ${message[0]}");
      debugPrint(message[1]);
    });

    connection.on('GroupMessage', (message) {
      debugPrint("new message for group ${message![0]} form user ${message[1]} received, message is ${message[2]}");
      debugPrint(message[1].toString());

      if (groups.containsKey(message[0])) {
        groups[message[0]]!.add({message[1]: message[2]});
      } else {
        groups[message[0]] = [];
        groups[message[0]]!.add({message[1]: message[2]});
      }

      setState(() {});
    });

    connection.on('ReceiveId', (message) {
      myId = message![0];
      debugPrint("client id is $myId");
      connection.invoke('ReceiveFireBaseToken', args: [firebaseToken]);
      debugPrint("connection status:  ${connection.state}");
      debugPrint("sending token");
      setState(() {});
    });

    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          tabs: tabs,
          controller: tabController,
        ),
        title: Center(
            child: Text(
          "My Id is $myId",
          style: const TextStyle(fontSize: 20, color: Colors.black),
        )),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          Center(
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: ListView(
                    children: [
                      ...contacts.entries.map((e) {
                        return Container(
                          child: TextButton(
                            onPressed: () {
                              selectedChat = e.key;
                              setState(() {});
                            },
                            child: Text("contact id is ${e.key}"),
                          ),
                        );
                      }).toList()
                    ],
                  ),
                )),
                Expanded(
                    child: ListView(
                  children: [
                    ...?contacts[selectedChat]?.map((e) {
                      debugPrint("the key is ${e.keys}");
                      return Column(
                        children: [
                          Column(
                            children: [
                              Align(
                                alignment: e.keys.first == -1 ? Alignment.centerLeft : Alignment.centerRight,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: e.keys.first == -1 ? Colors.green : Colors.blue,
                                  ),
                                  margin: const EdgeInsets.only(top: 5.0, bottom: 5.0, right: 5.0),
                                  height: 40,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 15.0, left: 15.0, top: 7),
                                    child: Text(
                                      e.keys.first.toString(),
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: e.keys.first == -1 ? Alignment.centerLeft : Alignment.centerRight,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: e.keys.first == -1 ? Colors.green : Colors.blue,
                                  ),
                                  margin: const EdgeInsets.only(top: 5.0, bottom: 5.0, right: 5.0),
                                  height: 40,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 15.0, left: 15.0, top: 7),
                                    child: Text(
                                      e.values.first,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }).toList()
                  ],
                ))
              ],
            ),
          ),
          Center(
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: ListView(
                    children: [
                      ...groups.entries.map((e) {
                        return Container(
                          child: TextButton(
                            onPressed: () {
                              selectedGroup = e.key;
                              setState(() {});
                            },
                            child: Text("Group name is ${e.key}"),
                          ),
                        );
                      }).toList()
                    ],
                  ),
                )),
                Expanded(
                    child: ListView(
                  children: [
                    ...?groups[selectedGroup]?.map((e) {
                      // return Column(
                      //   children: [
                      //     Align(
                      //       alignment: e.keys.first == myId ? Alignment.centerLeft : Alignment.centerRight,
                      //       child: SizedBox(
                      //         height: 40,
                      //         child: Text(
                      //           e.keys.first.toString(),
                      //           style: const TextStyle(fontSize: 20),
                      //         ),
                      //       ),
                      //     ),
                      //     Align(
                      //       alignment: e.keys.first == myId ? Alignment.centerLeft : Alignment.centerRight,
                      //       child: SizedBox(
                      //         height: 40,
                      //         child: Text(
                      //           e.values.first,
                      //           style: const TextStyle(fontSize: 20),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // );
                      return Align(
                        alignment: e.keys.first == myId ? Alignment.centerLeft : Alignment.centerRight,
                        child: Container(
                          margin: const EdgeInsets.only(top: 5.0, bottom: 5.0, right: 5.0),
                          height: 40,
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  color: e.keys.first == myId ? Colors.green : Colors.blue,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 15.0, left: 15.0, top: 7, bottom: 7),
                                  child: Text(
                                    e.keys.first.toString(),
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: e.keys.first == myId ? Colors.green : Colors.blue,
                                  ),
                                  margin: const EdgeInsets.only(left: 5.0, right: 5.0),
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 15.0, left: 15.0, top: 7),
                                    child: SizedBox(
                                      height: 40,
                                      child: Text(
                                        e.values.first,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      );
                    }).toList()
                  ],
                ))
              ],
            ),
          ),
          ListView(
            children: [
              Column(
                children: [
                  //
                  Form(
                    child: TextFormField(
                      controller: _controllerId,
                      decoration: const InputDecoration(labelText: "target client"),
                    ),
                  ),
                  Form(
                    child: TextFormField(
                      controller: _controllerMessage,
                      decoration: const InputDecoration(labelText: "Message"),
                    ),
                  ),
                  TextButton(
                      onPressed: () async {
                        int targetId = int.parse(_controllerId.text);
                        if (contacts.containsKey(targetId)) {
                          // it cant be null we check it above
                          contacts[targetId]?.add({-1: _controllerMessage.text});
                        } else {
                          contacts[targetId] = [
                            {-1: _controllerMessage.text}
                          ];
                        }
                        debugPrint(_controllerMessage.text);
                        debugPrint("sending message");
                        await connection.invoke('sendMessage', args: [targetId, _controllerMessage.text]);
                        setState(() {});
                      },
                      child: const Text("Send Message")),
                  //create group
                  Form(
                    child: TextFormField(
                      controller: _controllerJoinGroup,
                      decoration: const InputDecoration(labelText: "Group Name"),
                    ),
                  ),
                  TextButton(
                      onPressed: () async {
                        debugPrint(_controllerMessage.text);
                        debugPrint("AddToGroup");
                        await connection.invoke('AddToGroup', args: [_controllerJoinGroup.text]);
                      },
                      child: const Text("Join or create group")),
                  Form(
                    child: TextFormField(
                      controller: _controllerGroupNameSendMessage,
                      decoration: const InputDecoration(labelText: "Group Name"),
                    ),
                  ),
                  Form(
                    child: TextFormField(
                      controller: _controllerGroupSendMessage,
                      decoration: const InputDecoration(labelText: "Message"),
                    ),
                  ),
                  TextButton(
                      onPressed: () async {
                        debugPrint(_controllerMessage.text);
                        debugPrint("sending message to group");
                        await connection.invoke('SendMessageToGroup',
                            args: [_controllerGroupNameSendMessage.text, myId, _controllerGroupSendMessage.text]);
                        setState(() {});
                      },
                      child: const Text("Send Message to group")),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
