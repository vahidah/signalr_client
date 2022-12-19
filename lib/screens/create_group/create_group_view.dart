import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signalr_client/screens/chat/widgets/message.dart';

// import '/core/constants/constants.dart';
import '/core/dependency_injection.dart';
// import '/widgets/LoadingWidget.dart';
// import '/widgets/my_app_bar.dart';
import 'create_group_controller.dart';
// import '../widgets/drawer_widget.dart';
// import '../widgets/home_header.dart';
// import '../widgets/home_list_widget.dart';

class CreateGroupView extends StatelessWidget {
  final CreateGroupController myController = getIt<CreateGroupController>();

  CreateGroupView({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    myController.onInit();
    return SafeArea(
      child: Stack(
        children: [
          Image.asset(
            "assets/images/chatbackwhatsapp.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                // bottom: TabBar(
                //   tabs: tabs,
                //   controller: tabController,
                // ),
                  leading: IconButton(
                    onPressed: () {
                      myController.backToHomeScreen();
                    },
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "New group",
                        style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Add subject",
                        style: const TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ],
                  )),
              body:
              // myController.homeState.rebuildChatList.value;
              Container(
               height: MediaQuery.of(context).size.height/10,
                color: Colors.white,
                child: Row(
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 10, bottom: 10),
                        child: Stack(
                          children: [
                            Align(
                              child: CircleAvatar(
                                backgroundColor: Colors.grey,
                                radius: 50,
                                child: Icon(Icons.camera_alt, color: Colors.white70,),
                              ),
                              alignment: Alignment.center,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: CircleAvatar(
                                backgroundColor: Colors.blue,
                                radius: 12,
                                  child: Icon(Icons.add),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, bottom: 5,),
                      width: MediaQuery.of(context).size.width - 125,
                      child: TextFormField(
                        controller: myController.groupName,
                        decoration: InputDecoration(
                          hintText: "Type group subject here",
                          isDense: true,
                          contentPadding: EdgeInsets.zero
                        ),
                        style: TextStyle(fontSize: 20, decoration: TextDecoration.none),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Align(alignment: Alignment.centerLeft,child: Icon(Icons.add_reaction, color:Colors.black45)),
                    )
                  ],
                ),
              ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => myController.createGroup(),
              child: Icon(Icons.done, ),
            ),

            // Obx(() => myController.homeState.homeLoading.value
            //     ? const LoadingWidget()
            //     : SingleChildScrollView(
            //     padding: const EdgeInsets.only(bottom: 100),
            //     child: HomeListWidget(listFlights: myController.showFlightList()))),
          )
        ],
      ),
    );
  }
}
