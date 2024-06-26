import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/screens/tabs.dart';
import 'package:meals_app/widgets/main_drawer.dart';
enum Filter {glutenfree,lactosefree,vegan,vegetarian}

class filters_Screen extends StatefulWidget{
  const filters_Screen({super.key,required this.currentfilters});
final Map<Filter,bool>currentfilters;
  @override
  State<filters_Screen> createState() {
    return _filterstate();
  }
}

class _filterstate extends State<filters_Screen>{

  var _glutenfreefilterset=false;
  var _lactosefreefilterset=false;
  var _vegetarianfilterset=false;
  var _veganfilterset=false;


  @override
  void initState() {
    super.initState();

    _glutenfreefilterset=widget.currentfilters[Filter.glutenfree]!;
    _lactosefreefilterset=widget.currentfilters[Filter.lactosefree]!;
    _veganfilterset=widget.currentfilters[Filter.vegan]!;
    _vegetarianfilterset=widget.currentfilters[Filter.vegetarian]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your filters"),
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          if(didPop) return;
          Navigator.of(context).pop({
            Filter.glutenfree: _glutenfreefilterset,
            Filter.lactosefree: _lactosefreefilterset,
            Filter.vegetarian: _vegetarianfilterset,
            Filter.vegan: _veganfilterset,
          });
        },
        child:
        Column(
        children: [
          SwitchListTile(
            value: _glutenfreefilterset,
            onChanged: (isChecked){
              setState(() {
                _glutenfreefilterset=isChecked;
              });
            },
            title: Text("Gluten-Free",style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.onBackground),),
          subtitle: Text("Only includes Gluten-free meals", style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.onBackground),),
          activeColor: Theme.of(context).colorScheme.tertiary
          ,contentPadding: EdgeInsets.only(left: 34,right: 22),


          ),
          SwitchListTile(
            value: _lactosefreefilterset,
            onChanged: (isChecked){
              setState(() {
                _lactosefreefilterset=isChecked;
              });
            },
            title: Text("Lactose-Free",style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.onBackground),),
            subtitle: Text("Only includes Lactose-free meals", style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.onBackground),),
            activeColor: Theme.of(context).colorScheme.tertiary
            ,contentPadding: EdgeInsets.only(left: 34,right: 22),


          ),
          SwitchListTile(
            value: _vegetarianfilterset,
            onChanged: (isChecked){
              setState(() {
                _vegetarianfilterset=isChecked;
              });
            },
            title: Text("Vegetarian",style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.onBackground),),
            subtitle: Text("Only includes Vegetarian meals", style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.onBackground),),
            activeColor: Theme.of(context).colorScheme.tertiary
            ,contentPadding: EdgeInsets.only(left: 34,right: 22),


          ),
          SwitchListTile(
            value: _veganfilterset,
            onChanged: (isChecked){
              setState(() {
                _veganfilterset=isChecked;
              });
            },
            title: Text("Vegan",style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.onBackground),),
            subtitle: Text("Only includes Vegan meals", style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.onBackground),),
            activeColor: Theme.of(context).colorScheme.tertiary
            ,contentPadding: EdgeInsets.only(left: 34,right: 22),


          ),
        ],
      ),)
      // drawer: MainDrawer(onSelectScreen: (identifier) {
      //   Navigator.of(context).pop();
      //   if(identifier=="meals"){
      //     Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>TabsScreen()));
      //   }
      //   else{
      //
      //   }
      // },),
    )

      ;
  }
}
