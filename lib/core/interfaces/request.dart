import '/core/dependency_injection.dart';
// import '../../screens/login/login_state.dart';

abstract class Request {
  // final LoginState loginState = getIt<LoginState>();

  Map<String, dynamic> toJson();

  // String? get token => loginState.loginUser?.token;
}
