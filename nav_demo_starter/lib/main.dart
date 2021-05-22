import 'package:flutter/material.dart';
import './ui/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navigator 2.0 Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WillPopScope(
        child: HomePage(),
        onWillPop: () {
          return showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Exit App'),
                  content: const Text('Are you sure you want to exit the app?'),
                  actions: [
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () => Navigator.pop(context, true),
                    ),
                    TextButton(
                      child: const Text('Confirm'),
                      onPressed: () => Navigator.pop(context, false),
                    ),
                  ],
                );
              });
        },
      ),
    );
  }
}
