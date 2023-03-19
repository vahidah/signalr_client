import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:signalr_client/screens/chat/widgets/message.dart';
import 'package:signalr_client/widgets/ProjectTextField.dart';

import '/core/constants/ui.dart';
import '/core/dependency_injection.dart';
import 'create_group_controller.dart';
import 'create_group_state.dart';

class CreateGroupView extends StatelessWidget {
  final CreateGroupController myController = getIt<CreateGroupController>();

  CreateGroupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CreateGroupState state = context.watch<CreateGroupState>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: ProjectColors.backGroundOrangeType3,
            leading: IconButton(
              onPressed: () {
                myController.backToHomeScreen();
              },
              icon: const Icon(Icons.arrow_back, color: ProjectColors.fontWhite),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "New group",
                  style: TextStyle(fontSize: 20, color: ProjectColors.fontWhite, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Add subject",
                  style: TextStyle(fontSize: 12, color: ProjectColors.fontWhite),
                ),
              ],
            )),
        body: state.createGroupCompleted ? Stack(
          children: [
            Image.asset(
              "assets/images/chatbackwhatsapp.png",
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 10,
              color: ProjectColors.fontWhite,
              child: Row(
                children: [
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 10, bottom: 10),
                      child: Stack(
                        //it was previously stack
                        children: const [
                          Align(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              backgroundColor: ProjectColors.backGroundOrangeType3,
                              radius: 50,
                              child: Icon(
                                Icons.camera_alt,
                                color: ProjectColors.fontWhite,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: CircleAvatar(
                              backgroundColor: ProjectColors.backGroundOrangeType1,
                              radius: 12,
                              child: Icon(Icons.add),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 10,
                      bottom: 5,
                    ),
                    width: MediaQuery.of(context).size.width - 125,
                    child:
                    // ProjectTextField(
                    //   hintText: "Type group subject here",
                    //   style: const TextStyle(fontSize: 15, decoration: TextDecoration.none),
                    //   contentPadding:const EdgeInsets.symmetric(horizontal: 12),
                    //     controller: state.groupName
                    // )
                    Obx( () =>TextField(
                      style: const TextStyle(fontSize: 15, decoration: TextDecoration.none),
                          controller: state.groupNameController,
                        decoration: InputDecoration(
                          contentPadding:EdgeInsets.symmetric(horizontal: 12),
                          hintText: "Type group title here",
                          errorText: state.showError.value? "Please Enter group Name" : null
                        )
                    ))
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(Icons.add_reaction, color: ProjectColors.backGroundOrangeType1)),
                  )
                ],
              ),
            )
          ],
        ) : const Center(child: CircularProgressIndicator(),),
        floatingActionButton: state.createGroupCompleted ? FloatingActionButton(
          backgroundColor: ProjectColors.backGroundOrangeType1,
          onPressed: () => myController.createGroup(),
          child: const Icon(
            Icons.done,
          ),
        ) : null,
      ),
    );
  }
}
