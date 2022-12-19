import 'dart:async';

import 'package:flutter/material.dart';

// import '/widgets/loading_dialog.dart';
// import '/widgets/snack_bar_widget.dart';
// import '/widgets/top_dialog_bar.dart';
// import '../constants/ui.dart';
import '../interfaces/controller.dart';
// import '../util/moon_icons.dart';
import 'router.dart';

class NavigationService {
  final NavigationMode mode;
  final Map<String, MainController> _registeredControllers = {};
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final MyRouter router = MyRouter();

  NavigationService({this.mode = NavigationMode.goRouter});

  Future<dynamic> pushNamed(String routeName, {Map<String, String>? arguments}) {
    if (_registeredControllers.containsKey(routeName)) {
      _registeredControllers[routeName]!.onInit();
    }
    if (mode == NavigationMode.goRouter) {
      MyRouter.router.pushNamed(routeName, params: arguments ?? {});
      return Future.value(null);
    } else {
      return navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
    }
  }

  Future<dynamic> popAndTo(String routeName, {Map<String, String>? arguments}) {
    if (_registeredControllers.containsKey(routeName)) {
      _registeredControllers[routeName]!.onInit();
    }
    if (mode == NavigationMode.goRouter) {
      MyRouter.router.goNamed(routeName, params: arguments ?? {});
      return Future.value(null);
    } else {
      return navigatorKey.currentState!.popAndPushNamed(routeName, arguments: arguments);
    }
  }

  void goBack({dynamic result}) {
    if (mode == NavigationMode.goRouter) {
      MyRouter.router.pop();
    } else {
      return navigatorKey.currentState!.pop(result);
    }
  }

  void goToName(String routeName, {Map<String, String>? arguments, dynamic extra}) {
    if (_registeredControllers.containsKey(routeName)) {
      _registeredControllers[routeName]!.onInit();
    }
    if (mode == NavigationMode.goRouter) {
      MyRouter.router.goNamed(routeName, params: arguments ?? {}, extra: extra);
    } else {
      navigatorKey.currentState!.pushNamedAndRemoveUntil(routeName, (_) => false, arguments: arguments);
    }
  }

  BuildContext? get context => mode == NavigationMode.goRouter ? MyRouter.context : navigatorKey.currentState?.context;

  Future<dynamic> dialog(Widget content) => showDialog(context: context!, builder: (c) => content);

  snackBar(Widget content, {Color? backgroundColor, SnackBarAction? action, Duration? duration, IconData? icon}) {
    ScaffoldMessenger.of(context!).clearSnackBars();
    ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
      content: icon == null ? content : Row(children: [Icon(icon), const SizedBox(width: 8), Expanded(child: content)]),
      backgroundColor: backgroundColor,
      action: action,
      duration: duration ?? const Duration(seconds: 3),
    ));
  }

  registerController(String name, MainController controller) =>
      _registeredControllers.putIfAbsent(name, () => controller);

  void popDialog([dynamic result]) => Navigator.pop(context!, result);

  openBottomSheet({required Widget child, bool? isScrollControlled, AnimationController? animationController}) =>
      showModalBottomSheet(
        context: context!,
        isScrollControlled: isScrollControlled ?? false,
        transitionAnimationController: animationController,
        builder: (_) => child,
      );

  // showLoadingDialog({String? title}) => showDialog(
  //     barrierDismissible: false,
  //     context: context!,
  //     builder: (BuildContext context) => LoadingDialog(label: title ?? "Please wait ..."));

  // showTopSnack({
  //   required bool isSuccess,
  //   required String message,
  //   Function()? onPositivePressed,
  //   Function()? onNegativePressed,
  //   String? positiveLabel,
  //   String? negativeLabel,
  // }) =>
  //     showGeneralDialog(
  //         context: context!,
  //         pageBuilder: (_, __, ___) => TopDialogBar(
  //             child: SnackBarWidget(
  //                 color: isSuccess ? MyColors.turquoise : MyColors.red,
  //                 title: message,
  //                 negativeButton: negativeLabel ?? "",
  //                 positiveButton: positiveLabel ?? "",
  //                 onPositivePressed: () => onPositivePressed!(),
  //                 onNegativePressed: () => onNegativePressed!(),
  //                 icon: isSuccess ? MoonIcons.iconCheck : MoonIcons.iconError),
  //             onDismissed: () {}));
}

enum NavigationMode { version1, goRouter }
