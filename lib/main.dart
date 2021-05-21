import 'package:flutter/material.dart';
import 'package:flutter_course_1/providers/great_places.dart';
import 'package:flutter_course_1/screens/add_place_screen.dart';
import 'package:flutter_course_1/screens/places_list_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(Application());

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GreatPlaces(),
      builder: (context, child) => MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (_) => AddPlaceScreen(),
        },
      ),
    );
  }
}
