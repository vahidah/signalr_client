import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/screens/home/home_view.dart';
import '/screens/chat/chat_view.dart';
import '/screens/create_group/create_group_view.dart';
import '/screens/new_chat/new_chat_view.dart';
import '/screens/new_contact/new_contact_view.dart';
import '/screens/sign_up/sign_up_view.dart';
import '../constants/route_names.dart';

class MyRouter {
  MyRouter._();

  static final MyRouter _instance = MyRouter._();

  factory MyRouter() => _instance;
  static late GoRouter _router;
  static late List<RouteBase> _routes;

  static void initialize() {
    debugPrint("in initialize router1");
    _routes = <RouteBase>[
      // MyRoute(
      //   name: RouteNames.splash,
      //   path: '/splash',
      //   title: 'Splash',
      //   builder: (BuildContext context, GoRouterState state) => SplashView(),
      // ),
      MyRoute(
        name: RouteNames.chat,
        path: '/chatScreen',
        title: 'chat',
        builder: (BuildContext context, GoRouterState state) => ChatView(),
      ),
      MyRoute(
        name: RouteNames.home,
        path: "/home",
        title: 'Home',
        builder: (BuildContext context, GoRouterState state) => HomeView(),
      ),
      MyRoute(
        name: RouteNames.createGroup,
        path: '/create geGroup',
        title: 'Creatroup',
        builder: (BuildContext context, GoRouterState state) => CreateGroupView(),
      ),
      MyRoute(
        name: RouteNames.newChat,
        path: '/newChat',
        title: 'New Chat',
        builder: (BuildContext context, GoRouterState state) => NewChatView(),
      ),
      MyRoute(
        name: RouteNames.newContact,
        path: '/newContact',
        title: 'New Contact',
        builder: (BuildContext context, GoRouterState state) => NewContactView(),
      ),
      MyRoute(
        showInMainRoute: false,
        name: RouteNames.signUp,
        path: '/',
        title: '',
        builder: (BuildContext context, GoRouterState state) => SignUpView(),
      ),
      // MyRoute(
      //   name: RouteNames.addFlight,
      //   path: '/addFlight',
      //   title: 'Add Flight',
      //   builder: (BuildContext context, GoRouterState state) {
      //     if (state.extra == null) {
      //       return AddFlightView();
      //     } else {
      //       FlightElement? flightElement = state.extra as FlightElement;
      //       return AddFlightView(flightElement: flightElement);
      //     }
      //   },
      // ),
      // MyRoute(
      //   name: RouteNames.dispatch,
      //   path: '/dispatch',
      //   title: 'Dispatch',
      //   builder: (BuildContext context, GoRouterState state) => DispatchView(flightId: state.extra as int),
      // ),
    ];
    debugPrint("in initialize router2");
    _router = GoRouter(
      initialLocation: RouteNames.signUp,
      // refreshListenable: getIt<SplashState>(),

      routes: _routes,
      redirect: (context ,state) {
        if (kDebugMode) {
          print("State => ${state.subloc}");
        }
        return null;
      },
    );
  }

  // static List<String> get currentRouteTitles {
  //   String cp = _router.location;
  //   List<String> split = cp.split("/").where((element) => !element.startsWith(":")).toList();
  //   List<MyRoute> crl = [];
  //   for (var r in _routes) {
  //     if (split.contains(r.path.replaceFirst("/", ""))) {
  //       crl.add(r);
  //       for (var r2 in r.routes) {
  //         if (split.contains(r2.path.split("/").first)) {
  //           crl.add(r2);
  //           for (var r3 in r2.routes) {
  //             if (split.contains(r3.path.split("/").first)) {
  //               crl.add(r3);
  //               for (var r4 in r3.routes) {
  //                 if (split.contains(r4.path.split("/").first)) {
  //                   crl.add(r4);
  //                   for (var r5 in r4.routes) {
  //                     if (split.contains(r5.path.split("/").first)) {
  //                       crl.add(r5);
  //                       for (var r6 in r5.routes) {
  //                         if (split.contains(r6.path.split("/").first)) {
  //                           crl.add(r6);
  //                         }
  //                       }
  //                     }
  //                   }
  //                 }
  //               }
  //             }
  //           }
  //         }
  //       }
  //     }
  //   }
  //
  //   return crl.map((e) => e.title).toList();
  // }

  // static List<MyRoute> get currentRouteStack {
  //   String cp = _router.location;
  //   List<String> split = cp.split("/").where((element) => !element.startsWith(":")).toList();
  //   List<MyRoute> crl = [];
  //   for (var r in _routes) {
  //     if (split.contains(r.path.replaceFirst("/", ""))) {
  //       crl.add(r);
  //       for (var r2 in r.routes) {
  //         if (split.contains(r2.path.split("/").first)) {
  //           crl.add(r2);
  //           for (var r3 in r2.routes) {
  //             if (split.contains(r3.path.split("/").first)) {
  //               crl.add(r3);
  //               for (var r4 in r3.routes) {
  //                 if (split.contains(r4.path.split("/").first)) {
  //                   crl.add(r4);
  //                   for (var r5 in r4.routes) {
  //                     if (split.contains(r5.path.split("/").first)) {
  //                       crl.add(r5);
  //                       for (var r6 in r5.routes) {
  //                         if (split.contains(r6.path.split("/").first)) {
  //                           crl.add(r6);
  //                         }
  //                       }
  //                     }
  //                   }
  //                 }
  //               }
  //             }
  //           }
  //         }
  //       }
  //     }
  //   }
  //
  //   return crl;
  // }
  //
  // static List<String> get getTitles {
  //   List<String> titles = _routes.where((element) => element.showInMainRoute).map((r) => r.title).toList();
  //   return titles;
  // }

  static GoRouter get router => _router;

  static List<RouteBase> get routes => _routes;

  static BuildContext? get context => _router.routerDelegate.navigatorKey.currentContext;
  //_router.routerDelegate.navigatorKey.currentContext;
  // static BuildContext get context => _router.navigator!.context;


}

class MyRoute extends GoRoute {
  final String title;
  final String name;
  final Widget Function(BuildContext, GoRouterState) builder;

  final List<MyRoute> routes;
  final bool showInMainRoute;

  MyRoute(
      {required String path,
        required this.title,
        required this.name,
        required this.builder,
        this.routes = const [],
        this.showInMainRoute = true})
      : super(
    path: path,
    name: name,
    builder: builder,
    routes: routes,
    pageBuilder: (context, state) => NoTransitionPage<void>(key: state.pageKey, child: builder(context, state)),
  );

  Map<String, MyRoute> get getAllSubs {
    Map<String, MyRoute> matches = {title: this};
    for (var rr in routes) {
      String match = ('$path/${rr.path}').split(":")[0];
      matches.putIfAbsent(match, () => rr);
      for (var rrr in rr.routes) {
        String match2 = ("$path/${rr.path}/${rrr.path}").split(":")[0];
        matches.putIfAbsent(match2, () => rrr);
      }
    }
    return matches;
  }
}
