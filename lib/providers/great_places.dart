import 'dart:io';

import 'package:flutter/material.dart';

import '../models/place_location.dart';
import '../models/place.dart';

import '../helpers/db_helper.dart';
import '../helpers/location_helper.dart';

class GreatPlaces with ChangeNotifier {
  final List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Place findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> addPlace(
      String title, File image, PlaceLocation location) async {
    final address = await LocationHelper.getPlaceAddress(
      location.latitude,
      location.longitude,
    );
    final updatedLocation = PlaceLocation(
      latitude: location.latitude,
      longitude: location.longitude,
      address: address,
    );
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      image: image,
      location: updatedLocation,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address,
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
                  latitude: e['loc_lat'],
                  longitude: e['loc_lng'],
                  address: e['address'],
                ),
              ),
            ))
        .toList();
    notifyListeners();
  }
}
