import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/providers/meal_provider.dart';
import 'package:meals_app/screens/filters.dart';

enum Filter { glutenfree, lactosefree, vegan, vegetarian }

class Filtersnotifier extends StateNotifier<Map<Filter, bool>> {
  Filtersnotifier()
      : super({
          Filter.glutenfree: false,
          Filter.lactosefree: false,
          Filter.vegan: false,
          Filter.vegetarian: false,
        });

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<Filtersnotifier, Map<Filter, bool>>(
        (ref) => Filtersnotifier());
final filteredmealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activefilters = ref.watch(filtersProvider);
  return meals.where((meal) {
    if (activefilters[Filter.glutenfree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activefilters[Filter.lactosefree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activefilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    if (activefilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    return true;
  }).toList();
});
