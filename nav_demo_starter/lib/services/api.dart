import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/cocktail.dart';

abstract class Api {
  static Future<List<String>> fetchCategories() async {
    final response = await http.get(Uri.parse(
        'https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list'));

    if (response.statusCode != 200) throw Exception('Failed to get categories');

    final List categories = jsonDecode(response.body)['drinks'];

    return categories
        .map((element) => element['strCategory'].toString())
        .toList();
  }

  static Future<List<Cocktail>> fetchCocktails(String category) async {
    final response = await http.get(Uri.parse(
        'https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=$category'));

    if (response.statusCode != 200) throw Exception('Failed to get cocktails');

    final drinks = jsonDecode(response.body)['drinks'] as List;

    return drinks.map((element) => Cocktail.fromJson(element)).toList();
  }

  static Future<Cocktail> fetchRecipe(String id) async {
    final response = await http.get(Uri.parse(
        'https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=$id'));

    if (response.statusCode != 200) throw Exception('Failed to get recipe');

    final cocktail = (jsonDecode(response.body)['drinks'] as List).first;

    return Cocktail.fromJson(cocktail);
  }
}
