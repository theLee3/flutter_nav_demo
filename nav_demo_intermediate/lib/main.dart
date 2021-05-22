import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './router/delegate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final routerDelegate = Get.put(MyRouterDelegate());

  MyApp() {
    routerDelegate.setNewRoutePath([RouteSettings(name: '/')]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navigator 2.0 Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Router(
        routerDelegate: routerDelegate,
      ),
    );
  }
}
