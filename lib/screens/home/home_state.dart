import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/classes/chat.dart';

// import '/core/classes/airline_class.dart';
// import '/core/classes/flight_element_class.dart';
// import '/core/classes/flight_status_class.dart';
// import '/core/classes/home_notif_class.dart';
// import '/core/classes/login_class.dart';
// import '/core/classes/notif_class.dart';
// import '/core/classes/notif_type_class.dart';
// import '/core/util/moon_icons.dart';
// import '/core/util/utils.dart';

class HomeState with ChangeNotifier {
  setState() => notifyListeners();



  int myId = -1;
  String? firebaseToken;
  String? userName;
  RxBool userNameReceived = true.obs;
  int imageIndex = -1;


  List<Chat> chats = [];
  //todo add getter and setter



  RxBool rebuildChatList = false.obs;
  RxBool idReceived = false.obs;






// TextEditingController searchController = TextEditingController();
  //
  // List<FlightElement> listFlights = <FlightElement>[];
  // List<bool> showParts = [];
  // List<LoginMenu> menu = [];
  // List<Airline> airLines = [];
  // List<FlightStatusListElement> flightStatusList = [];
  // List<bool> isSelected = [false, true];
  //
  // RxBool homeLoading = false.obs;
  //
  // List<HomeMenuItem> menuItems = [
  //   HomeMenuItem(itemId: 0, title: NotifItems.news.getType, icon: MoonIcons.iconNews),
  //   HomeMenuItem(itemId: 1, title: NotifItems.task.getType, icon: MoonIcons.iconTask),
  //   HomeMenuItem(itemId: 2, title: NotifItems.notif.getType, icon: MoonIcons.iconAlarm),
  //   HomeMenuItem(itemId: 3, title: NotifItems.comment.getType, icon: MoonIcons.iconComment),
  // ];
  // RxInt currentSelectedIndex = 0.obs;
  //
  // RxBool showSearchBar = false.obs;
  // RxBool showLoading = true.obs;
  // RxBool showAssign = false.obs;
  // RxBool showStatus = false.obs;
  // RxBool showOperation = false.obs;
  // RxBool showReports = false.obs;
  // RxBool showReport = false.obs;
  // RxBool showTools = false.obs;
  //
  // RxInt assignControlValue = 1.obs;
  // RxInt statusControlValue = 1.obs;
  // RxInt operationControlValue = 1.obs;
  // RxInt reportControlValue = 1.obs;
  // RxInt selectedYear = DateTime.now().year.obs;
  // RxInt selectedMonth = DateTime.now().month.obs;
  // RxInt selectedDay = DateTime.now().day.obs;
  // RxInt days = Utils.daysInMonth(2022, DateTime.now().month).obs;
  //
  // RxString notifType = NotifType.markAll.getType.obs;
  // RxString selectedDate = "".obs;
  // RxString selectedWeekDay = "".obs;
  // String userName = "";
  // RxString searchValue = "".obs;
  //
  // TextEditingController editingController = TextEditingController();
  //
  // DateTime date = DateTime.now();
  //
  // ImageProvider? imageProvider;
  //
  // void setHomeLoading(bool val) {
  //   homeLoading(val);
  //   notifyListeners();
  // }
}