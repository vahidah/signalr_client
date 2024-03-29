import 'dart:convert';

import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:messaging_signalr/messaging_signalr.dart';
import 'package:provider/provider.dart';
import 'package:signalr_client/core/util/Extensions.dart';
import 'package:signalr_client/screens/chat/widgets/message.dart';
import 'package:signalr_client/screens/chat/widgets/message_date.dart';
import 'package:signalr_client/widgets/back_button.dart';

import '/core/constants/ui.dart';
import '/core/dependency_injection.dart';
import 'chat_controller.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'chat_state.dart';

class ChatView extends StatefulWidget {
  ChatView({Key? key}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final ChatController myController = getIt<ChatController>();

  final SignalRMessaging signalRMessaging = getIt<SignalRMessaging>();

  double? keyBoardHeight;

  //final listKey = GlobalKey();

  final UniqueKey _center = UniqueKey();

  @override
  void initState() {


    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    keyBoardHeight = MediaQuery.of(context).viewInsets.bottom;

    debugPrint("the value of keyBoardHeight is ${MediaQuery.of(context).viewInsets.bottom}");

    ChatState state = context.watch<ChatState>();
    myController.computeItemNumber();
    myController.datesShown = 0;

    if(state.emojiPickerInvisible == false){
      keyBoardHeight = 250;
    }

    return WillPopScope(
      onWillPop: myController.onWillPop,
      child: SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
                elevation: 0,
                backgroundColor: ProjectColors.backGroundOrangeType3,
                leading: BackButtonLocal(
                  onTap: myController.bachToHomeScreen,
                  color: ProjectColors.fontWhite,
                  size: ProjectSizes.chatPageIconFont,
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
                          height: 40,
                          width: 40,
                          decoration:
                              BoxDecoration(color: ProjectColors.fontWhite, borderRadius: BorderRadius.circular(20)),
                          child: state.selectedChat!.image == null
                              ? Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      state.selectedChat!.name.showInAvatar() ??
                                          state.selectedChat!.chatId.showInAvatar(),
                                      style: const TextStyle(
                                          color: ProjectColors.projectBlue, fontWeight: FontWeight.bold, fontSize: 50),
                                    ),
                                  ),
                                )
                              : CircleAvatar(
                                  backgroundImage: FileImage(state.selectedChat!.image!),
                                  // MemoryImage(base64.decode(state.selectedChat!.image!)),
                                  radius: 30,
                                )),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        state.selectedChat!.name.capitalizeFirstLetter() ??
                            state.selectedChat!.chatId.capitalizeFirstLetter(),
                        style:
                            const TextStyle(fontSize: 20, color: ProjectColors.fontWhite, fontWeight: FontWeight.bold),
                      ),
                      const Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
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
                          child: Padding(
                            padding: EdgeInsets.only(bottom:keyBoardHeight!),
                            child: Column(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                      height: MediaQuery.of(context).size.height - 140,
                                      child: CustomScrollView(
                                        anchor: 1,
                                        center: _center,
                                        //physics: NeverScrollableScrollPhysics(),
                                        slivers: [
                                          SliverToBoxAdapter(
                                            child: ScrollablePositionedList.builder(
                                            //initialAlignment: 70,
                                            itemPositionsListener: state.itemPositionsListener,

                                            //reverse: true,
                                            itemScrollController: state.itemScrollController,
                                            shrinkWrap: true,
                                            itemCount: myController.itemNumber,
                                            itemBuilder: (BuildContext context, int index) {
                                              if(myController.listViewElements[index] == 'date'){
                                                debugPrint("return date");
                                                String itemInfo = myController.listViewElements[index + 1]!;
                                                int indexOfItem = int.parse(itemInfo.split('|')[1]);
                                                return ChatDate(date: state.selectedChat!.messages[indexOfItem].date!);
                                              }else{
                                                debugPrint("return message");
                                                String itemInfo = myController.listViewElements[index]!;
                                                int indexOfItem = int.parse(itemInfo.split('|')[1]);
                                                var targetChat = state.selectedChat!.messages[indexOfItem];
                                                return MessageWidget(clientMessage: targetChat.senderPhoneNumber ==
                                                    signalRMessaging.myPhoneNumber,
                                                    chatType: state.selectedChat!.type, message: targetChat);
                                              }
                                            },
                                        ),
                                          ),
                                          SliverToBoxAdapter(
                                            key: _center,
                                              child: Container(
                                                height: 0,
                                              )
                                          )
                                        ]
                                      )),
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
                                                      icon: Icon(
                                                        state.showEmojiIcon.value ? Icons.emoji_emotions : Icons.keyboard,
                                                        color: ProjectColors.fontGray,
                                                        size: ProjectSizes.chatPageIconFont,
                                                      ),
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
                                                          icon: const Icon(Icons.attach_file,
                                                              color: ProjectColors.fontGray,
                                                              size: ProjectSizes.chatPageIconFont),
                                                          padding: EdgeInsets.zero,
                                                        )
                                                      : IconButton(
                                                          color: ProjectColors.backGroundOrangeType3,
                                                          onPressed: () => myController
                                                              .sendMessage(state.selectedChat!.type == ChatType.contact),
                                                          icon: const Icon(Icons.send, size: ProjectSizes.chatPageIconFont)),
                                                  state.textMessageController.text == ""
                                                      ? IconButton(
                                                          onPressed: () {
                                                            if (state.textMessageController.text == "") {
                                                              debugPrint("what is this");
                                                            }
                                                          },
                                                          icon: const Icon(Icons.camera_alt,
                                                              color: ProjectColors.fontGray,
                                                              size: ProjectSizes.chatPageIconFont),
                                                          padding: EdgeInsets.zero)
                                                      : const SizedBox(
                                                          height: 0,
                                                          width: 0,
                                                        )
                                                ],
                                              ),
                                              contentPadding: const EdgeInsets.all(10),
                                              hintText: "Message",
                                              hintStyle: const TextStyle(color: ProjectColors.fontGray2)),
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
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Offstage(
                          offstage: state.emojiPickerInvisible,
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
                      ),
                    ),
                  ],
                )),
      ),
    );
  }
}

