












import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/constants/ui.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: ProjectColors.backGroundOrangeType3,
        title: Text("Settings", style: TextStyle(fontSize: 20),),
          actions: [
            PopupMenuButton<int>(
              itemBuilder: (context) => [
                // PopupMenuItem 1
                PopupMenuItem(
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
