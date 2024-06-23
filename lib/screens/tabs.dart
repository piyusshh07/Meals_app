import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/meals.dart';

class TabsScreen extends StatefulWidget{

  TabsScreen({super.key});
  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}
class _TabsScreenState extends State<TabsScreen>{

  int  _selectedpageindex =0;
  void _selectpage(int index){
    setState(() {
      _selectedpageindex =index;
    });
  }
  @override
  Widget build(BuildContext context) {

    Widget activepage=CategoriesScreen();
    var Activepagetitle="Categories";

    if(_selectedpageindex==1){
      activepage=const MealsScreen(meals: []);
      Activepagetitle ="Your Favorite meals";
    }
    return
      Scaffold(
        appBar: AppBar(
          title: Text(Activepagetitle),
        ),
        body: activepage,
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectpage,
          currentIndex: _selectedpageindex,
          items: [
            BottomNavigationBarItem(icon:Icon(Icons.set_meal) ,label:"Categories" ),
            BottomNavigationBarItem(icon:Icon(Icons.star) ,label:"Favorites" )
          ],
        ),
      )
      ;
  }

}
