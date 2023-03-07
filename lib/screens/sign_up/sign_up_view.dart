import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:signalr_client/screens/sign_up/sign_up_controller.dart';
import 'package:signalr_client/screens/sign_up/sign_up_state.dart';
import 'package:signalr_client/screens/sign_up/widgets/pick_image_button.dart';
import 'package:signalr_client/widgets/ProjectTextField.dart';
import '../../core/navigation/navigation_service.dart';
import '/core/dependency_injection.dart';
import '/core/constants/ui.dart';

class SignUpView extends StatelessWidget {
  final SignUpController myController = getIt<SignUpController>();

  SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    SignUpState state = context.watch<SignUpState>();
    final NavigationService navigationService = getIt<NavigationService>();
    debugPrint("in signup view 1");
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: state.loading == false
            ? Stack(alignment: AlignmentDirectional.bottomCenter, children: [
                Container(
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
                    height: 60,
                    width: 250,
                    margin: const EdgeInsets.only(bottom: 260),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        stops: [0.9, 1],
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
                        child: Text("LOGIN", style: TextStyle(color: ProjectColors.fontBlackColorType1, fontSize: 20))),
                  ),
                ),
                Container(
                  height: 250,
                  width: 360,
                  margin: const EdgeInsets.only(bottom: 321),
                  decoration: BoxDecoration(
                    border: Border.all(color: ProjectColors.backGroundHalfTransparentType1, width: 0),
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    color: ProjectColors.backGroundHalfTransparentType1,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              color: ProjectColors.backGroundOrangeType3,
                              child: const Center(
                                child: Icon(
                                  Icons.person,
                                  size: 29,
                                  color: ProjectColors.fontWhite,
                                ),
                              ),
                            ),
                            Container(
                              width: 260,
                              height: 50,
                              color: ProjectColors.backGroundWhiteType1,
                              //const Color.fromRGBO(255, 165, 0, 1),
                              child: Obx ( () => TextField(

                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(left: 10, top: 5),
                                  border: InputBorder.none,
                                  hintText: "Name",
                                  hintStyle: const TextStyle(color: ProjectColors.fontBlackColorType1),
                                  errorText: state.validate.value ? null : "Username cant be empty",
                                ),
                                controller: state.nameController,
                              )),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 45, top: 32, left: 32),
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
                              child: Text("Remember me"),
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
                            icon: Icon(
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
            //         // Center(
            //         //   child: SingleChildScrollView(
            //         //     child: Column(
            //         //         crossAxisAlignment: CrossAxisAlignment.center,
            //         //         mainAxisAlignment: MainAxisAlignment.center,
            //         //         children: [
            //         //           const Text(
            //         //             "Please enter your name",
            //         //             style: TextStyle(color: ProjectColors.fontWhite, fontSize: 22),
            //         //           ),
            //         //           Container(
            //         //               width: screenWidth - 150,
            //         //               margin: const EdgeInsets.only(top: 10),
            //         //               child: Obx(() => ProjectTextField(
            //         //                     controller: state.nameController,
            //         //                     hintText: 'Enter user name',
            //         //                     validate: state.validate.value,
            //         //                     errorText: "Username cant be empty",
            //         //                   ))),
            //         //           SizedBox(
            //         //             width: 200,
            //         //             height: 200,
            //         //             child: state.image == null
            //         //                 ? const Icon(
            //         //                     Icons.camera_alt,
            //         //                     size: 80,
            //         //                   )
            //         //                 : Image.file(state.image!),
            //         //           ),
            //         //           PickImageButton(
            //         //               icon: Icons.image_search,
            //         //               title: "pick image from gallery",
            //         //               onclick: () => myController.pickImage(ImageSource.gallery),
            //         //               width: screenWidth - 150),
            //         //           Container(
            //         //             width: screenWidth - 200,
            //         //             margin: const EdgeInsets.only(top: 10),
            //         //             decoration: BoxDecoration(
            //         //               color: ProjectColors.fontWhite,
            //         //               borderRadius: BorderRadius.circular(20),
            //         //             ),
            //         //             child: TextButton(
            //         //               onPressed: () => myController.sendContactName(),
            //         //               style: TextButton.styleFrom(),
            //         //               child: const Text(
            //         //                 "Login",
            //         //                 style: TextStyle(fontSize: 24, color: ProjectColors.textBlackColorsType1),
            //         //               ),
            //         //             ),
            //         //           )
            //         //         ]),
            //         //   ),
            //         // ),
            //       ])
            : const SpinKitPouringHourGlassRefined(
                color: ProjectColors.fontWhite,
              ),
      ),
    );
  }
}
