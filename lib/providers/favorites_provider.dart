import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

class favoriteMealsNotifier extends StateNotifier<List<Meal>> {
  favoriteMealsNotifier() : super([]);

  bool toggleMealfavoriteStatus(Meal meal) {
    final mealIsfavorite = state.contains(meal);
    if (mealIsfavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealProvider =
    StateNotifierProvider<favoriteMealsNotifier, List<Meal>>((ref) {
  return favoriteMealsNotifier();
});
