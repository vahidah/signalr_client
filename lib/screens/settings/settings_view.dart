import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:signalr_client/screens/settings/settings_controller.dart';

import '../../core/constants/ui.dart';
import '../../core/dependency_injection.dart';

class SettingsView extends StatelessWidget {
  SettingsView({Key? key}) : super(key: key);

  final SettingsController myController = getIt<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: ProjectColors.backGroundOrangeType3,
        leading: IconButton(
          onPressed: () {
            myController.backToHome();
          },
          icon: const Icon(Icons.arrow_back, color: ProjectColors.fontWhite),
        ),
        title: const Text("Settings", style: TextStyle(fontSize: 20),),
          actions: [
            PopupMenuButton<int>(
              itemBuilder: (context) => [
                // PopupMenuItem 1
                PopupMenuItem(
                  onTap: () => myController.logout(),

                  value: 1,
                  // row with 2 children
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app, color: ProjectColors.fontBlackColorType1,),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Log Out")
                    ],
                  ),
                ),
              ],
              offset: Offset(0, 0),
              color: ProjectColors.fontWhite,
              elevation: 2,
              // on selected we show the dialog box
              onSelected: (value) {
                // if value 1 show dialog
                if (value == 1) {

                  // if value 2 show dialog
                } else if (value == 2) {

                }
              },
            ),
          ],
      ),
    ));
  }
}
