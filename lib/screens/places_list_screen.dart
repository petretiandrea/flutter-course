import 'package:flutter/material.dart';
import 'package:flutter_course_1/providers/great_places.dart';
import 'package:flutter_course_1/screens/add_place_screen.dart';
import 'package:flutter_course_1/widgets/loading_indicator.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your places'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).loadPlaces(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: LoadingIndicator('Loading places...'));
          } else {
            return Center(
              child: Consumer<GreatPlaces>(
                builder: (context, value, child) => value.items.length <= 0
                    ? child
                    : ListView.builder(
                        itemBuilder: (context, index) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                FileImage(value.items[index].image),
                          ),
                          title: Text(value.items[index].title),
                          onTap: () {
                            // todo: detail page
                          },
                        ),
                        itemCount: value.items.length,
                      ),
                child: Center(
                  child: Text('Got no places yet. Starting adding some!'),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
