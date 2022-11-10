import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:signalr_core/signalr_core.dart';

Future<void> main() async {
  runApp(const MyApp());
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

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controllerId = TextEditingController();
  final TextEditingController _controllerMessage = TextEditingController();

  List<Map<String, dynamic>> messageList = List.generate(0, (index) => {"hi": "hi"}, growable: true);

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

  @override
  initState() {
    // TODO: implement initState
    super.initState();

    _initializeSignalRConnection();

    connection.on('ReceiveNewMessage', (message) {
      messageList.add({"SenderId": message![0], "MessageText": message[1]});
      setState(() {});
      debugPrint("new message received");
      debugPrint(message[1]);
    });

    connection.on('ReceiveId', (message) {
      myId = message![0];
      debugPrint("client id is $myId");
      setState(() {});
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("chat app"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              color: Colors.blue,
              child: Center(
                child: Text("My id is: ${myId?? -1}"),
              ),
            ),
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
            ListView(
              shrinkWrap: true,
              children: messageList
                  .map((e) => Column(
                        children: [
                          Container(
                            child: Text("Sender Id is  ${e["SenderId"]}"),
                          ),
                          Container(
                            child: Text("Message: ${e["MessageText"]}"),
                          )
                        ],
                      ))
                  .toList(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          debugPrint(_controllerMessage.text);
          await connection.invoke('sendMessage', args: [int.parse(_controllerId.text), _controllerMessage.text]);
        },
        child: const Icon(Icons.send),
      ),
    );
  }
}
