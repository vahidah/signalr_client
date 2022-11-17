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

  List<Map<String, dynamic>> messageList = List.generate(0, (index) => {"hi": "hi"}, growable: true);
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

  Map<int, List<String>> contacts = <int, List<String>>{};

  int selectedChat = -1;

  @override
  initState() {
    // TODO: implement initState
    super.initState();

    _initializeSignalRConnection();

    _getToken();

    connection.on('ReceiveNewMessage', (message) {
      messageList.add({"SenderId": message![0], "MessageText": message[1]});
      if (contacts.containsKey(message[0])) {
        // it cant be null we check it above
        contacts[message[0]]?.add(message[1]);
      } else {
        contacts[message[0]] = [message[1]];
      }
      setState(() {});
      debugPrint("new message received");
      debugPrint(message[1]);
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
                    color: Colors.black54,
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
                              //setState(() {});
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
                      return Container(
                        height: 100,
                        child: Center(
                          child: Text(
                            e,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      );
                    }).toList()
                  ],
                ))
              ],
            ),
          ),
          Center(
            child: Text("defalut"),
          ),
          Column(
            children: [
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
                    debugPrint(_controllerMessage.text);
                    debugPrint("sending message");
                    await connection
                        .invoke('sendMessage', args: [int.parse(_controllerId.text), _controllerMessage.text]);
                  },
                  child: const Text("Send Message"))
            ],
          )
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     debugPrint(_controllerMessage.text);
      //     debugPrint("sending message");
      //     await connection.invoke('sendMessage', args: [int.parse(_controllerId.text), _controllerMessage.text]);
      //   },
      //   child: const Icon(Icons.send),
      // ),
    );
  }
}

// Center(
// child: Column(
// children: [
// Container(
// color: Colors.blue,
// child: Center(
// child: Text("My id is: ${myId ?? -1}"),
// ),
// ),
// Form(
// child: TextFormField(
// controller: _controllerId,
// decoration: const InputDecoration(labelText: "target client"),
// ),
// ),
// Form(
// child: TextFormField(
// controller: _controllerMessage,
// decoration: const InputDecoration(labelText: "Message"),
// ),
// ),
// ListView(
// shrinkWrap: true,
// children: messageList
//     .map((e) => Column(
// children: [
// Container(
// child: Text("Sender Id is  ${e["SenderId"]}"),
// ),
// Container(
// child: Text("Message: ${e["MessageText"]}"),
// )
// ],
// ))
// .toList(),
// )
// ],
// ),
// ),
// floatingActionButton: FloatingActionButton(
// onPressed: () async {
// debugPrint(_controllerMessage.text);
// debugPrint("sending message");
// await connection.invoke('sendMessage', args: [int.parse(_controllerId.text), _controllerMessage.text]);
// },
// child: const Icon(Icons.send),
// ),
// );
