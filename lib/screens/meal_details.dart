import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/main.dart';

import '../models/meal.dart';

class MealDetailsScreen extends StatelessWidget {
  MealDetailsScreen({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(meal.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                meal.imageUrl,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 14,),
               Text('Ingredients',
                 style: Theme.of(context).
                 textTheme.titleLarge!.
                 copyWith(color: Theme.of(context).
                 colorScheme.primary,fontWeight: FontWeight.bold),
               ),
             SizedBox(height: 10,) ,
              for(final ingredient in meal.ingredients)
                Text(ingredient,
                  style: Theme.of(context).
                textTheme.bodyMedium!.
                copyWith(color: Theme.of(context).
                colorScheme.onBackground),),
              SizedBox(height: 20,),
              Text('Steps',
                style: Theme.of(context).
                textTheme.titleLarge!.
                copyWith(color: Theme.of(context).
                colorScheme.primary,fontWeight: FontWeight.bold),
              ),
              for(final steps in meal.steps)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                  child: Expanded(
                    child: Text(steps,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).
                      textTheme.bodyMedium!.
                      copyWith(color: Theme.of(context).
                      colorScheme.onBackground),),
                  ),
                ),
          
            ],
          ),
        ));
  }
}
