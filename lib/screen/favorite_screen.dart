import 'package:flutter/material.dart';
import 'package:flutter_course_1/model/meal.dart';
import 'package:flutter_course_1/widget/meal_item_list.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;

  FavoriteScreen(this.favoriteMeals);

  @override
  Widget build(BuildContext context) {
    return favoriteMeals.isEmpty
        ? Center(
            child: Text('You have no favorites yet - start adding someone'),
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              final meal = favoriteMeals[index];
              return MealItemList(
                id: meal.id,
                title: meal.title,
                imageUrl: meal.imageUrl,
                affordability: meal.affordability,
                duration: meal.duration,
                complexity: meal.complexity,
                removeItemHandler: null,
              );
            },
            itemCount: favoriteMeals.length,
          );
  }
}
