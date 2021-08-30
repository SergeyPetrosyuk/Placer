import 'package:flutter/material.dart';
import 'package:placer/model/place_model.dart';

class PlacesProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items => [..._items];
}
