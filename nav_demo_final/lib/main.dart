import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './router/information_parser.dart';
import './router/delegate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final routerDelegate = Get.put(MyRouterDelegate());

  MyApp() {
    routerDelegate.pushPage(name: '/');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Navigator 2.0 Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerDelegate: routerDelegate,
      routeInformationParser: const MyRouteInformationParser(),
    );
  }
}
