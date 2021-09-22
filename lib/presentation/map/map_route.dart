import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:placer/model/place_model.dart';

const DEFAULT_LATITUDE = 37.422;
const DEFAULT_LONGITUDE = -122.084;

class MapRoute extends StatefulWidget {
  final PlaceLocation placeLocation;
  final String placeAddress;
  final bool isSelecting;

  const MapRoute({
    this.placeLocation = const PlaceLocation(
      latitude: DEFAULT_LATITUDE,
      longitude: DEFAULT_LONGITUDE,
    ),
    this.isSelecting = false,
    this.placeAddress = "",
  });

  @override
  _MapRouteState createState() => _MapRouteState();
}

class _MapRouteState extends State<MapRoute> {
  LatLng? _pickedLocation;

  void _selectLocation(LatLng coordinates) {
    setState(() {
      _pickedLocation = coordinates;
    });
  }

  void _returnLocation() {
    Navigator.of(context).pop(_pickedLocation);
  }

  @override
  Widget build(BuildContext context) {
    final lat = widget.placeLocation.latitude;
    final lng = widget.placeLocation.longitude;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.placeAddress),
        actions: [
          if (widget.isSelecting && _pickedLocation != null)
            IconButton(
              onPressed: _returnLocation,
              icon: Icon(Icons.done_rounded),
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(lat, lng),
          zoom: 17,
        ),
        onTap: widget.isSelecting ? _selectLocation : null,
        markers: (_pickedLocation == null && widget.isSelecting)
            ? {}
            : {
                Marker(
                  markerId: MarkerId("m1"),
                  position: _pickedLocation ?? LatLng(lat, lng),
                ),
              },
      ),
    );
  }
}
