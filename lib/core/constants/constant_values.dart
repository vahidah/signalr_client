



class ConstValues{
  ConstValues._();

  static late String fireBaseToken;
  // static late int myId = -1;
  static late String userName;


  static late bool isUserLoggedIn;

  static const int minPhoneNumberLength = 10;
  static const int maxPhoneNumberLength = 12;
}

class RegExpressions{

  static var phoneNumber = RegExp(r'^(?:[+0][1-9])?[0-9]{10,12}$');
}