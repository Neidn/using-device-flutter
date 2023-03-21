import 'dart:io';

import 'package:flutter/material.dart';

import '../models/place_location.dart';
import '../models/place.dart';

import '../helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  final List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  void addPlace(String title, File image) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      image: image,
      location: PlaceLocation(
        latitude: 37.422,
        longitude: -122.084,
        address: 'Googleplex Mountain View, CA, USA',
      ),
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items.clear();

    dataList
        .map((e) => _items.add(
              Place(
                id: e['id'],
                title: e['title'],
                image: File(e['image']),
                location: PlaceLocation(
                  latitude: 37.422,
                  longitude: -122.084,
                  address: 'Googleplex Mountain View, CA, USA',
                ),
              ),
            ))
        .toList();
    notifyListeners();
  }
}
