import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/cocktail.dart';
import '../router/delegate.dart';
import '../services/api.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final routerDelegate = Get.find<MyRouterDelegate>();

  List<String> _categories = [];
  List<Cocktail> _cocktails;

  @override
  void initState() {
    Api.fetchCategories().then((categories) {
      if (mounted) setState(() => _categories = categories);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Navigator 2.0 Demo'),
        leading: _cocktails != null
            ? IconButton(
                icon: Icon(kIsWeb || Platform.isIOS
                    ? Icons.arrow_back_ios
                    : Icons.arrow_back),
                onPressed: () => setState(() => _cocktails = null),
              )
            : null,
      ),
      body: _cocktails == null
          ? ListView.builder(
              itemCount: _categories.length,
              itemBuilder: (context, index) => ListTile(
                    title: Text(_categories[index]),
                    onTap: () {
                      Api.fetchCocktails(_categories[index]).then((cocktails) =>
                          setState(() => _cocktails = cocktails));
                    },
                  ))
          : GridView.builder(
              itemCount: _cocktails.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 1.0),
              itemBuilder: (context, index) => InkWell(
                child: Stack(
                  children: [
                    Image.network(_cocktails[index].thumbUrl,
                        fit: BoxFit.fitWidth),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: const EdgeInsets.all(4.0),
                          decoration: ShapeDecoration(
                            color: Colors.black45,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                          child: FittedBox(
                              child: Text(
                            _cocktails[index].name,
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () => routerDelegate.pushPage(
                  name: '/recipe',
                  arguments: {
                    'id': _cocktails[index].id,
                  },
                ),
              ),
            ),
    );
  }
}
