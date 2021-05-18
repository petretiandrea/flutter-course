import 'package:flutter/material.dart';
import 'package:flutter_course_1/model/meal.dart';
import 'package:flutter_course_1/widget/meal_item_list.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meal> _meals;

  static Map<String, Object> arguments(String id, String categoryTitle) {
    return {'id': id, 'title': categoryTitle};
  }

  CategoryMealsScreen(this._meals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String _categoryTitle;
  List<Meal> _categoryMeals;
  bool _loadedInitData = false;

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, Object>;

      final categoryId = routeArgs['id'].toString();
      _categoryTitle = routeArgs['title'].toString();

      _categoryMeals = this
          .widget
          ._meals
          .where((meal) => meal.categories.contains(categoryId))
          .toList();
      _loadedInitData = true;
    }

    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      _categoryMeals.removeWhere((element) => element.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_categoryTitle),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (context, index) {
            final meal = _categoryMeals[index];
            return MealItemList(
              id: meal.id,
              title: meal.title,
              imageUrl: meal.imageUrl,
              affordability: meal.affordability,
              duration: meal.duration,
              complexity: meal.complexity,
              removeItemHandler: _removeMeal,
            );
          },
          itemCount: _categoryMeals.length,
        ),
      ),
    );
  }
}
