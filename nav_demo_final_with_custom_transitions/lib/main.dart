import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nav_demo/router/custom_transition_builder.dart';
import './router/information_parser.dart';
import './router/delegate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final routerDelegate = Get.put(MyRouterDelegate());

  MyApp({Key? key}) : super(key: key) {
    routerDelegate.pushPage(name: '/');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Navigator 2.0 Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: CustomTransitionBuilder(),
          TargetPlatform.iOS: CustomTransitionBuilder(),
          TargetPlatform.macOS: CustomTransitionBuilder(),
          TargetPlatform.windows: CustomTransitionBuilder(),
          TargetPlatform.linux: CustomTransitionBuilder(),
        }),
      ),
      routerDelegate: routerDelegate,
      routeInformationParser: const MyRouteInformationParser(),
    );
  }
}
