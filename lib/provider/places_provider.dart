import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:placer/db/db_helper.dart';
import 'package:placer/location/location_helper.dart';
import 'package:placer/model/place_model.dart';

class PlacesProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items => [..._items];

  Future<void> addPlace(
      String title, File image, PlaceLocation placeLocation) async {
    final readableAddress = await _geocodeLatLng(
      placeLocation.latitude,
      placeLocation.longitude,
    );
    final place = Place(
      id: DateTime.now().toString(),
      title: title,
      image: image,
      location: PlaceLocation(
        latitude: placeLocation.latitude,
        longitude: placeLocation.longitude,
        address: readableAddress,
      ),
    );

    _items.add(place);
    notifyListeners();

    DbHelper.insert(
      table: 'places',
      data: {
        'id': place.id,
        'title': place.title,
        'image': place.image.path,
        'latitude': placeLocation.latitude,
        'longitude': placeLocation.longitude,
        'address': readableAddress,
      },
    );
  }

  Future<void> fetchPlaces() async {
    final data = await DbHelper.getAll('places');
    _items = data
        .map((dbItem) => Place(
      id: dbItem['id'] as String,
              title: dbItem['title'] as String,
              location: PlaceLocation(
                latitude: dbItem['latitude'] as double,
                longitude: dbItem['longitude'] as double,
                address: dbItem['address'] as String,
              ),
              image: File(dbItem['image'] as String),
            ))
        .toList();
    notifyListeners();
  }

  Future<String> _geocodeLatLng(double latitude, double longitude) async {
    final url = Uri.https('maps.googleapis.com', 'maps/api/geocode/json', {
      'latlng': '$latitude, $longitude',
      'key': GOOGLE_API_KEY,
    });
    final response = await http.get(url, headers: {
      'x-android-package': 'com.example.placer.placer',
      'x-android-cert': '873961CEF2725CA91372FE672A9A45098FFD2EB3',
    });

    print(json.decode(response.body));
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
