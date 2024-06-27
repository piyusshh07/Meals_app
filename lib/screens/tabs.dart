import 'package:flutter/material.dart';
import 'package:meals_app/providers/meal_provider.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/providers/filters_provider.dart';

const kInitialFiletrs = {
  Filter.glutenfree: false,
  Filter.lactosefree: false,
  Filter.vegan: false,
  Filter.vegetarian: false
};

class TabsScreen extends ConsumerStatefulWidget {
  TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedpageindex = 0;

  void _selectpage(int index) {
    setState(() {
      _selectedpageindex = index;
    });
  }

  void _setScreen(String idnetifier) async {
    Navigator.of(context).pop();
    if (idnetifier == "filters") {
      await Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(builder: (ctx) => const filters_Screen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredmealsProvider);

    Widget activepage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    var Activepagetitle = "Categories";

    if (_selectedpageindex == 1) {
      final favoriteMeals = ref.watch(favoriteMealProvider);
      activepage = MealsScreen(
        meals: favoriteMeals,
      );
      Activepagetitle = "Your Favorite meals";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(Activepagetitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activepage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectpage,
        currentIndex: _selectedpageindex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites")
        ],
      ),
    );
  }
}
