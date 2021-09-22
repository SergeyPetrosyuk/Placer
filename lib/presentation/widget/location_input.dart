import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:placer/location/location_helper.dart';
import 'package:placer/presentation/map/map_route.dart';

class LocationInputWidget extends StatefulWidget {
  final Function(double lat, double lng) selectPlace;

  const LocationInputWidget({required this.selectPlace});

  @override
  _LocationInputWidgetState createState() => _LocationInputWidgetState();
}

class _LocationInputWidgetState extends State<LocationInputWidget> {
  String? _locationPreviewUrl;

  Future<void> _getCurrentUserLocation() async {
    final location = await Location().getLocation();
    final latitude = location.latitude;
    final longitude = location.longitude;

    if (latitude == null || longitude == null) return;

    final locationPreviewUrl = LocationHelper.generateLocationPreview(
      latitude: latitude,
      longitude: longitude,
    );

    setState(() {
      _locationPreviewUrl = locationPreviewUrl.toString();
    });

    widget.selectPlace(latitude, longitude);
  }

  Future<void> _selectOnMap() async {
    final LatLng? selectedLocation =
        await Navigator.of(context).push<LatLng>(MaterialPageRoute(
      builder: (builderContext) => MapRoute(
        isSelecting: true,
      ),
    ));

    if (selectedLocation == null) return;

    final locationPreviewUrl = LocationHelper.generateLocationPreview(
      latitude: selectedLocation.latitude,
      longitude: selectedLocation.longitude,
    );

    setState(() {
      _locationPreviewUrl = locationPreviewUrl.toString();
    });

    widget.selectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black45, width: 2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: _mapPreviewWidget,
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _getCurrentUserLocation,
                  icon: Icon(Icons.location_on_rounded),
                  label: Text('Current Location'),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _selectOnMap,
                  icon: Icon(Icons.map_rounded),
                  label: Text('Select on Map'),
                ),
              ),
            ],
          ),
        ],
      );

  Widget get _mapPreviewWidget {
    final String? locationPreview = _locationPreviewUrl;
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: locationPreview == null
          ? Center(child: Text('No location yet'))
          : Image.network(
              locationPreview,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 150,
            ),
    );
  }
}
