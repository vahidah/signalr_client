import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signalr_client/screens/chat/widgets/message.dart';
import 'package:signalr_client/screens/sign_up/sign_up_controller.dart';

// import '/core/constants/constants.dart';
import '/core/dependency_injection.dart';
// import '/widgets/LoadingWidget.dart';
// import '/widgets/my_app_bar.dart';
import 'sign_up_controller.dart';
// import '../widgets/drawer_widget.dart';
// import '../widgets/home_header.dart';
// import '../widgets/home_list_widget.dart';

class SignUpView extends StatelessWidget {
  final SignUpController myController = getIt<SignUpController>();

  SignUpView({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    myController.onInit();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Obx( () {
          myController.signUpState.rebuild.value;

          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Text("Please enter your name", style: TextStyle(color: Colors.white, fontSize: 22),),
                Container(
                  width: MediaQuery.of(context).size.width - 150,
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    controller: myController.nameController,
                    decoration: InputDecoration(
                      hintText: 'Enter user name',
                      border: InputBorder.none
                    ),
                  ),
                ),
                Container(
            width: MediaQuery.of(context).size.width - 200,
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            ),
                  child: TextButton(
                    onPressed: () => myController.sendContactName(),
                    child: const Text("Login", style: TextStyle(fontSize: 24),),
                  ),
                )
              ]

            ),
          );
    }
      ),
    ));
  }
}
