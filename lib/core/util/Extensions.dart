



extension StringExtension on String {
  String capitalizeFirstLetter() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}


extension StringExtension1 on String {
  String showInAvatar() {
    return substring(0,length > 1 ? 2 : 1).toUpperCase();
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month
        && day == other.day;
  }
}