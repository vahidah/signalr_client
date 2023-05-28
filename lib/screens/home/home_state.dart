import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/classes/chat.dart';


class HomeState with ChangeNotifier {


  TextEditingController searchChat = TextEditingController();

  setState() => notifyListeners();


  final TextEditingController searchController = TextEditingController();

  FocusNode searchFocus = FocusNode();

  bool isSearchEmpty = true;


  int _stackIndex = 0;

  set setStackIndex(int newValue) {
    _stackIndex = newValue;

    notifyListeners();
  }



  int? get stackIndex => _stackIndex;





}