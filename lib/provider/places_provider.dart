import 'dart:io';

import 'package:flutter/material.dart';
import 'package:placer/model/place_model.dart';

class PlacesProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items => [..._items];

  void addPlace(String title, File image) {
    final place = Place(
      id: DateTime.now().toString(),
      title: title,
      image: image,
      location: PlaceLocation(latitude: 0.0, longitude: 0.0, address: ''),
    );

    _items.add(place);
    notifyListeners();
  }
}
