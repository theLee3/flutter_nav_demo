class Cocktail {
  String id, name, instructions, thumbUrl;
  List<Map<String, String>> ingredients = [];

  Cocktail.fromJson(Map<String, dynamic> json)
      : id = json['idDrink'],
        name = json['strDrink'],
        instructions = json['strInstructions'] ?? '',
        thumbUrl = json['strDrinkThumb'] {
    for (int i = 1; i <= 15; i++) {
      if (json['strIngredient$i'] != null) {
        ingredients.add({
          'ingredient': json['strIngredient$i'],
          'measurement': json['strMeasure$i'] ?? ''
        });
      }
    }
  }
}
