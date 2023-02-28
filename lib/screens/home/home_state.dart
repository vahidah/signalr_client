import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/classes/chat.dart';


class HomeState with ChangeNotifier {
  setState() => notifyListeners();


  final TextEditingController searchController = TextEditingController();

  FocusNode searchFocus = FocusNode();
  // RxList<Chat> chats = <Chat>[].obs;







}