






import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:provider/provider.dart';


import '../../../core/constants/ui.dart';
import '../sign_up_state.dart';

class FieldsContainer extends StatelessWidget {
  FieldsContainer({Key? key, required this.children, required this.bottomPadding,
    required this.height, required this.width}) : super(key: key);


  List<Widget> children;
  final double height;
  final double width;
  final double bottomPadding;


  @override
  Widget build(BuildContext context) {

    SignUpState state = context.watch<SignUpState>();

    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.only(bottom: bottomPadding),
      decoration: BoxDecoration(
        border: Border.all(color: ProjectColors.backGroundHalfTransparentType1, width: 0),
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        color: ProjectColors.backGroundHalfTransparentType1,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          ...children,

          Padding(
            padding: const EdgeInsets.only(bottom: 15, top: 10, left: 32),
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
    );
  }
}
