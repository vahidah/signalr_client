import 'dart:convert';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:messaging_signalr/messaging_signalr.dart';
import 'package:provider/provider.dart';
import 'package:signalr_client/core/util/Extensions.dart';
import 'package:signalr_client/screens/chat/widgets/message.dart';
import 'package:signalr_client/screens/chat/widgets/message_date.dart';

import '/core/constants/ui.dart';
import '/core/dependency_injection.dart';
import 'chat_controller.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'chat_state.dart';

class ChatView extends StatelessWidget {
  ChatView({Key? key}) : super(key: key);

  final ChatController myController = getIt<ChatController>();

  final SignalRMessaging signalRMessaging = getIt<SignalRMessaging>();
  @override
  Widget build(BuildContext context) {
    ChatState state = context.watch<ChatState>();
    DateTime? lastDateShown;
    myController.computeItemNumber();
    myController.datesShown = 0;
    return WillPopScope(
      onWillPop: myController.onWillPop,
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: ProjectColors.backGroundOrangeType3,
                leading: IconButton(
                  onPressed: () {
                    myController.bachToHomeScreen();
                  },
                  icon: const Icon(Icons.arrow_back, color: ProjectColors.fontWhite),
                ),
                title: InkWell(
                  onTap: () => myController.nav.snackBar(
                    Text(
                      "contact id is: ${state.selectedChat!.chatId}",
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.all(10),
                          height: 40,
                          width: 40,
                          decoration:
                              BoxDecoration(color: ProjectColors.fontWhite, borderRadius: BorderRadius.circular(20)),
                          child: state.selectedChat!.image == null
                              ? FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    state.selectedChat!.userName?.showInAvatar() ??
                                        state.selectedChat!.chatId.showInAvatar(),
                                    style: const TextStyle(
                                        color: ProjectColors.projectBlue, fontWeight: FontWeight.bold, fontSize: 50),
                                  ),
                                )
                              : Image.memory(base64.decode(state.selectedChat!.image!))),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        state.selectedChat!.userName?.capitalizeFirstLetter() ??
                            state.selectedChat!.chatId.capitalizeFirstLetter(),
                        style:
                            const TextStyle(fontSize: 20, color: ProjectColors.fontWhite, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Icon(Icons.more_vert),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
            body:
                // myController.homeState.rebuildChatList.value;
                Stack(
              children: [
                Image.asset(
                  "assets/images/background.jpg",
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),

                Column(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height - 140,
                        child: ScrollablePositionedList.builder(
                          itemPositionsListener: state.itemPositionsListener,
                          itemScrollController: state.itemScrollController,
                          shrinkWrap: true,
                          itemCount: myController.itemNumber,
                          itemBuilder: (BuildContext context, int index) {
                            debugPrint("index value is $index");
                            if (index == 0) {
                              debugPrint("index 0 item : ${myController.datesShown}");
                              DateTime currentDate = state.selectedChat!.messages[0].date!;
                              lastDateShown = currentDate;
                              myController.datesShown = 1;
                              debugPrint("index 0 item : ${myController.datesShown}");
                              return Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: MessageDate(date: currentDate),
                              );
                            } else {
                              //todo is this method correct?
                              debugPrint("index is : $index");
                              debugPrint("values ${myController.datesShown} and $index");
                              if (!state.selectedChat!.messages[index - myController.datesShown].date!
                                  .isSameDate(lastDateShown!)) {
                                DateTime currentDate =
                                    state.selectedChat!.messages[index - myController.datesShown].date!;
                                lastDateShown = currentDate;
                                myController.datesShown++;
                                return MessageDate(date: currentDate);
                              } else {
                                return MessageWidget(
                                  clientMessage: state.selectedChat!.messages[index - myController.datesShown].sender ==
                                      signalRMessaging.myId,
                                  chatType: state.selectedChat!.type,
                                  message: state.selectedChat!.messages[index - myController.datesShown],
                                );
                              }
                            }
                          },
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // AnimatedIcon(icon: AnimatedIcons., progress: ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                            // margin: const EdgeInsets.only(left: 2, right: 2),
                            // shape: RoundedRectangleBorder(
                            //   borderRadius: BorderRadius.circular(25),
                            // ),
                            // height: 125,
                            color: Colors.white,
                            child: TextField(
                              style: const TextStyle(fontSize: 18),
                              onTap: myController.tapOnTextField,
                              // on
                              focusNode: state.textInputFocus,
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              minLines: 1,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Obx(() => AnimatedSwitcher(
                                      duration: const Duration(milliseconds: 1000),
                                      transitionBuilder: (Widget child, Animation<double> animation) {
                                        return ScaleTransition(scale: animation, child: child);
                                      },
                                      child: IconButton(
                                        focusColor: ProjectColors.backGroundOrangeType1,
                                        icon: Icon(state.showEmojiIcon.value ? Icons.emoji_emotions : Icons.keyboard,
                                            color: ProjectColors.fontGray, size: ProjectSizes.chatPageIconFont,),
                                        onPressed: () async {
                                          myController.toggleEmojiKeyboard();
                                        },
                                      ),
                                    )),
                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    state.textMessageController.text == ""
                                        ? IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.attach_file, color: ProjectColors.fontGray, size: ProjectSizes.chatPageIconFont),
                                            padding: EdgeInsets.zero,
                                          )
                                        : IconButton(
                                            color: ProjectColors.backGroundOrangeType3,
                                            onPressed: () =>
                                                myController.sendMessage(state.selectedChat!.type == ChatType.contact),
                                            icon: const Icon(Icons.send, size: ProjectSizes.chatPageIconFont)),
                                    state.textMessageController.text == ""
                                        ? IconButton(
                                            onPressed: () {
                                              if (state.textMessageController.text == "") {
                                                debugPrint("what is this");
                                              }
                                            },
                                            icon: const Icon(
                                              Icons.camera_alt,
                                              color: ProjectColors.fontGray,
                                                size: ProjectSizes.chatPageIconFont
                                            ),
                                            padding: EdgeInsets.zero)
                                        : const SizedBox(
                                            height: 0,
                                            width: 0,
                                          )
                                  ],
                                ),
                                contentPadding: const EdgeInsets.all(10),
                                hintText: "Message",
                                hintStyle: const TextStyle(color: ProjectColors.fontGray2)
                              ),
                              controller: state.textMessageController,
                              onChanged: (str) => myController.textControllerChanged(str),
                            ),
                          ),
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 2, right: 2, bottom: 8),
                          //   child: CircleAvatar(
                          //     backgroundColor: ProjectColors.backGroundOrangeType2,
                          //     radius: 25,
                          //     child: state.textMessageController.text == ""
                          //         ? IconButton(
                          //             onPressed: () {},
                          //             icon: const Icon(Icons.mic),
                          //             color: ProjectColors.backGroundOrangeType3,
                          //           )
                          //         : IconButton(
                          //             color: ProjectColors.backGroundOrangeType3,
                          //             onPressed: () =>
                          //                 myController.sendMessage(state.selectedChat!.type == ChatType.contact),
                          //             icon: const Icon(Icons.send)),
                          //   ),
                        )
                      ],
                    ),
                    Offstage(
                      offstage: state.emojiPickerVisible,
                      child: SizedBox(
                          height: 250,
                          child: EmojiPicker(
                            onEmojiSelected: (category, emoji) => myController.onEmojiSelected(category, emoji),
                            textEditingController: state.emojiController,
                            config: Config(
                              columns: 7,
                              // Issue: https://github.com/flutter/flutter/issues/28894
                              emojiSizeMax: 32 * (foundation.defaultTargetPlatform == TargetPlatform.iOS ? 1.30 : 1.0),
                              verticalSpacing: 0,
                              horizontalSpacing: 0,
                              gridPadding: EdgeInsets.zero,
                              initCategory: Category.RECENT,
                              bgColor: const Color(0xFFF2F2F2),
                              indicatorColor: Colors.blue,
                              iconColor: Colors.grey,
                              iconColorSelected: Colors.blue,
                              backspaceColor: Colors.blue,
                              skinToneDialogBgColor: Colors.white,
                              skinToneIndicatorColor: Colors.grey,
                              enableSkinTones: true,
                              showRecentsTab: true,
                              recentsLimit: 28,
                              replaceEmojiOnLimitExceed: false,
                              noRecents: const Text(
                                'No Recents',
                                style: TextStyle(fontSize: 20, color: Colors.black26),
                                textAlign: TextAlign.center,
                              ),
                              loadingIndicator: const SizedBox.shrink(),
                              tabIndicatorAnimDuration: kTabScrollDuration,
                              categoryIcons: const CategoryIcons(),
                              buttonMode: ButtonMode.MATERIAL,
                              checkPlatformCompatibility: true,
                            ),
                          )),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
