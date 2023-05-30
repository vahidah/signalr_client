import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:signalr_client/screens/sign_up/sign_up_controller.dart';
import 'package:signalr_client/screens/sign_up/sign_up_state.dart';
import 'package:signalr_client/screens/sign_up/widgets/fields_container.dart';
import 'package:signalr_client/screens/sign_up/widgets/choose_page_button.dart';
import 'package:signalr_client/screens/sign_up/widgets/login_button.dart';
import 'package:signalr_client/screens/sign_up/widgets/text_field_signup.dart';
import '/core/dependency_injection.dart';
import '/core/constants/ui.dart';

class SignUpView extends StatefulWidget {

  SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final SignUpController myController = getIt<SignUpController>();


  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    SignUpState state = context.watch<SignUpState>();
    return WillPopScope(
      onWillPop: () async {
        state.setIndexStack = 0;
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: state.loading == false
              ? Stack(alignment: AlignmentDirectional.bottomCenter, children: [
                  Container(
                    width: screenWidth,
                    height: screenHeight,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      colors: [
                        ProjectColors.backGroundWhiteType1,
                        ProjectColors.backGroundOrangeType2,
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    )),
                  ),
                  IndexedStack(
                    alignment: AlignmentDirectional.bottomCenter,
                    index: state.getIndexStack,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 200),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ChoosePageButton(title: "Login"),
                            SizedBox(height: 30,),
                            ChoosePageButton(title: "SignUp")
                          ],
                        ),
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          LoginButton(title: "SignUp", bottomPadding: 260, onTap: myController.signUp),
                         FieldsContainer(
                             bottomPadding: 310, height: 290, width: 360,
                             children: [
                               TextFieldSignUp(
                                 icon: Icons.person,
                                 title: "Name",
                                 controller: state.nameController,
                                 validate: state.nameValidate,
                                 errorMessage: "Username can not be empty",
                               ),
                               const SizedBox(
                                 height: 10,
                               ),
                               TextFieldSignUp(
                                 icon: Icons.phone,
                                 title: "Phone Number",
                                 controller: state.phoneNumberController,
                                 validate: state.phoneValidate,
                                 errorMessage: "Please enter valid phone number",

                               ),
                               const SizedBox(
                                 height: 10,
                               ),
                               TextFieldSignUp(
                                 icon: Icons.vpn_key,
                                 title: "Password",
                                 controller: state.passwordController,
                                 validate: state.passwordValidate,
                                 errorMessage: "Password should at least include 8 character",
                                 password: true,

                               ),
                             ]),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 540),
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                  color: ProjectColors.backGroundOrangeType2,
                                  border: Border.all(width: 0, color: ProjectColors.backGroundOrangeType2),
                                  borderRadius: BorderRadius.circular(60)),
                              child: state.image == null
                                  ? IconButton(
                                icon: const Icon(
                                  Icons.person_2_outlined,
                                  color: ProjectColors.fontWhite,
                                  size: 70,
                                ),
                                onPressed: () => myController.pickImage(ImageSource.gallery),
                              )
                                  : CircleAvatar(
                                radius: 60,
                                backgroundImage: FileImage(state.image!),
                              ),
                            ),
                          )
                        ],
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                         children: [
                           FieldsContainer(
                            height: 180,
                            width: 360,
                            bottomPadding: 310,
                            children: [
                              TextFieldSignUp(
                                icon: Icons.phone,
                                title: "Phone Number",
                                controller: state.phoneNumberController,
                                validate: state.phoneValidate,
                                errorMessage: "Please enter valid phone number",

                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFieldSignUp(
                                icon: Icons.vpn_key,
                                title: "Password",
                                controller: state.passwordController,
                                validate: state.passwordValidate,
                                errorMessage: "Password should at least include 8 character",
                                password: true,

                              ),
                            ],
                          ),
                           LoginButton(title: "Login", bottomPadding: 260, onTap: myController.login,)
          ]
                      )
                    ],
                  ),

                ])
              : const SpinKitPouringHourGlassRefined(
                  color: ProjectColors.fontWhite,
                ),
        ),
      ),
    );
  }
}



