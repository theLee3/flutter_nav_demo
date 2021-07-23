import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/cocktail.dart';
import '../services/api.dart';
import './recipe.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Navigator 2.0 Demo'),
          leading: _cocktails != null
              ? IconButton(
                  icon: const Icon(kIsWeb || Platform.isIOS
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
                        Api.fetchCocktails(_categories[index]).then(
                            (cocktails) =>
                                setState(() => _cocktails = cocktails));
                      },
                    ))
            : GridView.builder(
                itemCount: _cocktails.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 1.0),
                itemBuilder: (context, index) => InkWell(
                  child: Stack(
                    children: [
                      DecoratedBox(
                        position: DecorationPosition.foreground,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment(0.0, 0.25),
                            colors: [
                              Colors.black38,
                              Colors.transparent,
                            ],
                          ),
                        ),
                        child: Image.network(_cocktails[index].thumbUrl,
                            fit: BoxFit.cover, scale: 0.5),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: FittedBox(
                              child: Text(
                            _cocktails[index].name,
                            style: const TextStyle(color: Colors.white),
                          )),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return RecipePage(_cocktails[index].id);
                    }));
                  },
                ),
              ),
      ),
    );
  }

  Future<bool> _onWillPop() {
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Exit App'),
            content: const Text('Are you sure you want to exit the app?'),
            actions: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.pop(context, false),
              ),
              TextButton(
                child: const Text('Confirm'),
                onPressed: () => Navigator.pop(context, true),
              ),
            ],
          );
        });
  }
}
