import 'package:flutter/material.dart';
import '../models/cocktail.dart';
import '../services/api.dart';

class RecipePage extends StatefulWidget {
  final String _id;

  const RecipePage(this._id, {Key key}) : super(key: key);

  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  Cocktail _cocktail;

  @override
  void initState() {
    Api.fetchRecipe(widget._id)
        .then((cocktail) => setState(() => _cocktail = cocktail));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _cocktail != null
          ? CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 250.0,
                  flexibleSpace: FlexibleSpaceBar(
                    background: DecoratedBox(
                      position: DecorationPosition.foreground,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment(0.0, 0.25), // Alignment.center,
                          colors: [
                            Colors.black38,
                            Colors.transparent,
                          ],
                        ),
                      ),
                      child:
                          Image.network(_cocktail.thumbUrl, fit: BoxFit.cover),
                    ),
                    title: Text(_cocktail.name),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(left: 12.0, top: 12.0),
                    child: Text('Ingredients',
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold)),
                  ),
                ),
                SliverFixedExtentList(
                  itemExtent: 50.0,
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => ListTile(
                      title: Text(
                          _cocktail.ingredients[index]['ingredient'] ?? ''),
                      subtitle: Text(
                          _cocktail.ingredients[index]['measurement'] ?? ''),
                    ),
                    childCount: _cocktail.ingredients.length,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 12.0, top: 24.0, bottom: 12.0),
                    child: Text('Instructions',
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold)),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      _cocktail.instructions,
                      softWrap: true,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
