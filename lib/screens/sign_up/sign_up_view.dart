import 'package:flutter/material.dart';
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
        backgroundColor: ProjectColors.projectBlue,
        body: state.loading == false
            ? Center(
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Please enter your name",
                          style: TextStyle(color: ProjectColors.fontWhite, fontSize: 22),
                        ),
                        Container(
                            width: screenWidth - 150,
                            margin: const EdgeInsets.only(top: 10),
                            child: ProjectTextField(controller: state.nameController, hintText: 'Enter user name')),
                        SizedBox(
                          width: 200,
                          height: 200,
                          child: state.image == null
                              ? const Icon(
                                  Icons.camera_alt,
                                  size: 80,
                                )
                              : Image.file(state.image!),
                        ),
                        PickImageButton(
                            icon: Icons.image_search,
                            title: "pick image from gallery",
                            onclick: () => myController.pickImage(ImageSource.gallery),
                            width: screenWidth - 150),
                        Container(
                          width: screenWidth - 200,
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: ProjectColors.fontWhite,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextButton(
                            onPressed: () => myController.sendContactName(),
                            style: TextButton.styleFrom(),
                            child: const Text(
                              "Login",
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        )
                      ]),
                ),
              )
            : const SpinKitPouringHourGlassRefined(
                color: ProjectColors.fontWhite,
              ),
      ),
    );
  }
}
