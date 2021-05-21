import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_course_1/helpers/db_helper.dart';
import 'package:flutter_course_1/models/place.dart';

class GreatPlaces with ChangeNotifier {
  var _items = IList<Place>.from([]);

  List<Place> get items => _items.toList();

  Future<void> loadPlaces() async {
    final places = await _fetchLocalPlaces();
    _items = IList.from(places);
    notifyListeners();
  }

  Future<List<Place>> _fetchLocalPlaces() async {
    final data = await DBHelper.getData('user_places');
    return data
        .map((e) => Place(
              id: e['id'],
              image: File(e['image']),
              title: e['title'],
              location: null,
            ))
        .toList();
  }

  void addPlace(String title, File image) {
    final place = Place(
      id: DateTime.now().toString(),
      image: image,
      title: title,
      location: null,
    );

    _items = _items.appendElement(place);
    notifyListeners();

    DBHelper.insert('user_places', {
      'id': place.id,
      'title': place.title,
      'image': place.image.path,
    });
  }
}
