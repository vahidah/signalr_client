class Apis {
  Apis._();

  static const baseUrl = "http://10.0.2.2:9000/api/Image";

  static const getImage = "http://10.0.2.2:5003/api/Image";
  static const login = "${baseUrl}api/Login";
  static const execute = "${baseUrl}api/Execute";
  static const airLineLogo = "http://testapi.dcs.faranegar.com/api/GetAirlineImage/5?nullForNotExists=true&airlineCode=";
}
