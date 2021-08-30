import 'package:flutter/material.dart';
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
          scaffoldBackgroundColor: Color.fromRGBO(230, 230, 230, 1),
          primaryColor: Colors.indigo,
          accentColor: Colors.purple,
        ),
        home: PlacesRoute(),
      ),
    );
  }
}
