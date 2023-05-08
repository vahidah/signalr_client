import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:signalr_client/screens/sign_up/sign_up_controller.dart';
import 'package:signalr_client/screens/sign_up/sign_up_state.dart';
import 'package:signalr_client/screens/sign_up/widgets/text_field_signup.dart';
import '/core/dependency_injection.dart';
import '/core/constants/ui.dart';

class SignUpView extends StatelessWidget {
  final SignUpController myController = getIt<SignUpController>();

  SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    SignUpState state = context.watch<SignUpState>();
    return SafeArea(
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
                GestureDetector(
                  onTap: () => myController.sendContactName(),
                  child: Container(
                    height: 50,
                    width: 300,
                    margin: const EdgeInsets.only(bottom: 260),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        stops: [0.7, 1],
                        colors: [
                          ProjectColors.backGroundHalfTransparentType1,
                          ProjectColors.backGroundBlackType1,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                      border: Border.all(color: ProjectColors.backGroundHalfTransparentType1, width: 0),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                      // color: ProjectColors.backGroundHalfTransparentType1
                    ),
                    child: const Center(
                        child: Text("LOGIN",
                            style: TextStyle(color: ProjectColors.fontBlackColorType1, fontSize: 20),
                            //style: TextStyle(color: ProjectColors.fontBlackColorType1, fontSize: 20)
                        )),
                  ),
                ),
                Container(
                  height: 250,
                  width: 360,
                  margin: const EdgeInsets.only(bottom: 311),
                  decoration: BoxDecoration(
                    border: Border.all(color: ProjectColors.backGroundHalfTransparentType1, width: 0),
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    color: ProjectColors.backGroundHalfTransparentType1,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextFieldSignUp(icon: Icons.person, title: "Name",
                          controller: state.nameController, validate: state.nameValidate, errorMessage: "Please enter valid phone number",),
                      const SizedBox(height: 10,),
                      // TextFieldSignUp(icon: Icons.phone, title: "Phone Number", controller: state.phoneNumberController,
                      //     validate: state.phoneValidate, errorMessage: "Username cant be empty",),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30, top: 25, left: 32),
                        child: Row(
                          children: [
                            Obx(() => GestureDetector(
                                  child: Container(
                                    width: 15,
                                    height: 15,
                                    color: state.checkBoxValue.value
                                        ? ProjectColors.backGroundGreenType1
                                        : ProjectColors.backGroundWhiteType1,
                                    child: Center(
                                        child: state.checkBoxValue.value
                                            ? const Icon(
                                                Icons.done,
                                                color: ProjectColors.fontWhite,
                                                size: 14,
                                              )
                                            : Container()),
                                  ),
                                  onTap: () {
                                    debugPrint("onTapCalled");
                                    state.checkBoxValue.toggle();
                                  },
                                )),
                            const Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                  "Remember me",
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 501),
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
                        : CircleAvatar(radius: 60, backgroundImage: FileImage(state.image!),),
                  ),
                )
              ])
            : const SpinKitPouringHourGlassRefined(
                color: ProjectColors.fontWhite,
              ),
      ),
    );
  }
}
