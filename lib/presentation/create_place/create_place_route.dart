import 'dart:io';

import 'package:flutter/material.dart';
import 'package:placer/model/place_model.dart';
import 'package:placer/presentation/widget/image_input.dart';
import 'package:placer/presentation/widget/location_input.dart';
import 'package:placer/provider/places_provider.dart';
import 'package:provider/provider.dart';

class CreatePlaceRoute extends StatefulWidget {
  static const ROUTE = '/create-place';

  @override
  _CreatePlaceRouteState createState() => _CreatePlaceRouteState();
}

class _CreatePlaceRouteState extends State<CreatePlaceRoute> {
  final _titleController = TextEditingController();
  File? _pickedImageFile;
  PlaceLocation? _placeLocation;

  void _selectImage(File file) {
    print(file.path);
    setState(() {
      _pickedImageFile = file;
    });
  }

  void _selectPlace(double latitude, double longitude) {
    _placeLocation = PlaceLocation(latitude: latitude, longitude: longitude);
  }

  void _savePlace() {
    final title = _titleController.text;
    final pickedImage = _pickedImageFile;
    final location = _placeLocation;

    if (title.isEmpty || pickedImage == null || location == null) {
      print('Incorrect input');
      return;
    }

    final PlacesProvider placesProvider = context.read<PlacesProvider>();
    placesProvider.addPlace(title, pickedImage, location);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text('Create a Place')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                      TextField(
                        controller: _titleController,
                        decoration: InputDecoration(labelText: 'Title'),
                      ),
                      SizedBox(height: 16),
                      ImageInputWidget(selectImageFunc: _selectImage),
                      SizedBox(height: 16),
                      LocationInputWidget(selectPlace: _selectPlace),
                    ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _savePlace,
            icon: Icon(Icons.add_rounded),
            label: Text('Create Place'),
            style: ElevatedButton.styleFrom(
                elevation: 0,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.only(bottom: 28, top: 20)),
          )
        ],
      ),
    );
}
