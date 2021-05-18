import 'package:flutter/material.dart';
import 'package:flutter_course_1/model/meal.dart';
import 'package:flutter_course_1/screen/categories_screen.dart';
import 'package:flutter_course_1/screen/favorite_screen.dart';
import 'package:flutter_course_1/widget/main_drawer.dart';

class TabScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  TabScreen(this.favoriteMeals);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Map<String, Object>> _pages;
  int _currentPage = 0;

  void _selectPage(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pages = [
      {'page': CategoriesScreen(), 'title': 'Categories'},
      {'page': FavoriteScreen(widget.favoriteMeals), 'title': 'Favorite'},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          title: Text(_pages[_currentPage]['title']),
        ),
        drawer: MainDrawer(),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white.withAlpha(200),
          selectedItemColor: Theme.of(context).accentColor,
          currentIndex: _currentPage,
          type: BottomNavigationBarType.fixed,
          onTap: _selectPage,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.category),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.star),
              label: 'Favorite',
            )
          ],
        ),
        body: _pages[_currentPage]['page'],
      ),
      length: 2,
      initialIndex: 0,
    );
  }
}
