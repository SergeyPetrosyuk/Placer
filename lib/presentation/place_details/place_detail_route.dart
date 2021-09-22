import 'package:flutter/material.dart';
import 'package:placer/model/place_model.dart';
import 'package:placer/presentation/map/map_route.dart';
import 'package:placer/provider/places_provider.dart';
import 'package:provider/provider.dart';

class PlaceDetailRoute extends StatelessWidget {
  static const ROUTE = '/place-details';

  @override
  Widget build(BuildContext context) {
    final String placeId = ModalRoute.of(context)?.settings.arguments as String;

    final Place place = context
        .read<PlacesProvider>()
        .items
        .firstWhere((element) => element.id == placeId);

    return Scaffold(
      appBar: AppBar(title: Text(place.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 270,
              width: double.infinity,
              child: Image.file(place.image, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                place.location.address,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (builderContext) => MapRoute(
                    placeLocation: place.location,
                    isSelecting: false,
                    placeAddress: place.title,
                  ),
                ));
              },
              child: Text('View on Map'),
            ),
          ],
        ),
      ),
    );
  }
}
