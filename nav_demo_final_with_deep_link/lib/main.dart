import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_links/uni_links.dart';
import './router/information_parser.dart';
import './router/delegate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final routerDelegate = Get.put(MyRouterDelegate());
  final routeInformationParser = const MyRouteInformationParser();

  StreamSubscription _linkSubscription;

  @override
  void initState() {
    super.initState();
    routerDelegate.pushPage(name: '/');

    if (!kIsWeb) initialize();
  }

  @override
  void dispose() {
    _linkSubscription.cancel();
    super.dispose();
  }

  Future<void> initialize() async {
    try {
      // Get the link that launched the app
      final initialUri = await getInitialUri();

      if (initialUri != null) routerDelegate.parseRoute(initialUri);
    } on FormatException catch (error) {
      error.printError();
    }

    // Attach a listener to the uri_links stream
    _linkSubscription = uriLinkStream.listen((uri) {
      if (!mounted) return;

      routerDelegate.parseRoute(uri);
    }, onError: (error) => error.printError());
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
      routeInformationParser: routeInformationParser,
    );
  }
}
