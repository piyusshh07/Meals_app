import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

const kInitialFiletrs={
  Filter.glutenfree : false,
  Filter.lactosefree : false,
  Filter.vegan : false,
  Filter.vegetarian:false
};
class TabsScreen extends StatefulWidget {
  TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedpageindex = 0;

  final List<Meal> _favoriteMeals = [];

  Map<Filter,bool> _selectedfilters=kInitialFiletrs;

  void _showinfomessage(String Message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(Message)));
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
        _showinfomessage("Meal is no longer Favorite");
      });
    } else {
      setState(() {
        _favoriteMeals.add(meal);
        _showinfomessage("Meal is added to Fovorite");
      });
    }
  }

  void _selectpage(int index) {
    setState(() {
      _selectedpageindex = index;
    });
  }

  void _setScreen(String idnetifier) async {
   Navigator.of(context).pop();
    if (idnetifier == "filters") {
      final result= await Navigator.of(context)
          .push<Map<Filter, bool >>(MaterialPageRoute(
          builder: (ctx) =>
              filters_Screen(currentfilters: _selectedfilters)));
      setState(() {
        _selectedfilters=result ?? kInitialFiletrs;
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals =dummyMeals.where((meal) {
      if(_selectedfilters [Filter.glutenfree]! && !meal.isGlutenFree){
        return false;
      }
      if(_selectedfilters [Filter.lactosefree]! && !meal.isLactoseFree){
        return false;
      }
      if(_selectedfilters [Filter.vegan]! && !meal.isVegan){
        return false;
      }
      if(_selectedfilters [Filter.vegetarian]! && !meal.isVegetarian){
        return false;
      }
      return true;
    }).toList();

    Widget activepage = CategoriesScreen(
      OnTogglefavorite: _toggleMealFavoriteStatus,
      availableMeals: availableMeals,
    );
    var Activepagetitle = "Categories";

    if (_selectedpageindex == 1) {
      activepage = MealsScreen(
        meals: _favoriteMeals,
        OnTogglefavorite: _toggleMealFavoriteStatus,
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
