import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:placer/presentation/create_place/create_place_route.dart';
import 'package:placer/presentation/place_details/place_detail_route.dart';
import 'package:placer/presentation/places/places_route.dart';
import 'package:placer/provider/places_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: PlacesProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Placer',
        theme: ThemeData(
          appBarTheme: Theme.of(context).appBarTheme.copyWith(brightness: Brightness.dark),
          scaffoldBackgroundColor: Color.fromRGBO(230, 230, 230, 1),
          primaryColor: Colors.indigo,
          accentColor: Colors.purple,
          primarySwatch: Colors.purple
        ),
        home: PlacesRoute(),
        routes: {
          CreatePlaceRoute.ROUTE: (builderContext) => CreatePlaceRoute(),
          PlaceDetailRoute.ROUTE: (builderContext) => PlaceDetailRoute()
        },
      ),
    );
  }
}
