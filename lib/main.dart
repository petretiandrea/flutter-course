import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_course_1/dummy_data.dart';
import 'package:flutter_course_1/screen/category_meals_screen.dart';
import 'package:flutter_course_1/screen/filter_screen.dart';
import 'package:flutter_course_1/screen/meal_detail_screen.dart';
import 'package:flutter_course_1/screen/tabs_screen.dart';

import 'model/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      if (_filters.values.contains(true)) {
        _availableMeals = DUMMY_MEALS.where((meal) {
          return (_filters['gluten'] && meal.isGlutenFree) ||
              (_filters['lactose'] && meal.isLactoseFree) ||
              (_filters['vegan'] && meal.isVegan) ||
              (_filters['vegetarian'] && meal.isVegetarian);
        }).toList();
      } else {
        _availableMeals = DUMMY_MEALS;
      }
    });
  }

  void _toggleFavorite(String mealId) {
    setState(() {
      final index =
          _favoriteMeals.indexWhere((element) => element.id == mealId);

      setState(() {
        if (index >= 0) {
          _favoriteMeals.removeAt(index);
        } else {
          _favoriteMeals.add(
              _availableMeals.firstWhere((element) => element.id == mealId));
        }
      });
    });
  }

  bool _isMealFavorite(String mealId) {
    return _favoriteMeals.any((element) => element.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              headline6: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => TabScreen(_favoriteMeals),
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (context) =>
            MealDetailScreen(_toggleFavorite, _isMealFavorite),
        FilterScreen.routeName: (context) => FilterScreen(_filters, _setFilters)
      },
      onGenerateRoute: (routeSettings) {
        print(routeSettings.arguments);
        //return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
      onUnknownRoute: (routeSettings) {
        //return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
