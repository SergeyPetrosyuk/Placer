import 'package:flutter/material.dart';
import 'package:placer/presentation/create_place/create_place_route.dart';
import 'package:placer/provider/places_provider.dart';
import 'package:provider/provider.dart';

class PlacesRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(CreatePlaceRoute.ROUTE);
            },
            icon: Icon(Icons.add_rounded),
          ),
        ],
      ),
      body: FutureBuilder(
        future: context.read<PlacesProvider>().fetchPlaces(),
        builder: (builderContext, snapshot) => Consumer<PlacesProvider>(
          child: Center(child: const Text('No places yet, start adding some!')),
          builder: (builderContext, provider, child) => provider.items.isEmpty
              ? child!
              : ListView.builder(
                  itemCount: provider.items.length,
                  itemBuilder: (itemBuilderContext, index) {
                    final item = provider.items[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: FileImage(item.image),
                      ),
                      title: Text(item.title),
                      onTap: () {
                        // Go to detail page
                      },
                    );
                  },
                ),
        ),
      ),
    );
  }
}
