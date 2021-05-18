import 'package:flutter/material.dart';
import 'package:flutter_course_1/model/category.dart';
import 'package:flutter_course_1/screen/category_meals_screen.dart';

class CategoryItemList extends StatelessWidget {
  final Category _category;

  CategoryItemList(this._category);

  void _selectCategory(BuildContext context) {
    final navigator = Navigator.of(context);
    navigator.pushNamed(
      CategoryMealsScreen.routeName,
      arguments: CategoryMealsScreen.arguments(
        _category.id,
        _category.title,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Text(
          _category.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _category.color.withOpacity(0.7),
              _category.color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
