import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ChatState with ChangeNotifier {
  setState() => notifyListeners();

  TextEditingController editingController = TextEditingController();
  late TabController tabController;

  // RxList<FlightReport> list = <FlightReport>[].obs;

  RxBool showLoading = true.obs;
  RxBool isExpanded = false.obs;
  RxDouble height = (50.0).obs;

  // List<FlightReport> get dispatchList => list;

  // void setDispatchLoading(bool val) {
  //   showLoading(val);
  //   notifyListeners();
  // }
  //
  // void setDispatchList(List<FlightReport> val) {
  //   list(val);
  //   notifyListeners();
  // }
}
