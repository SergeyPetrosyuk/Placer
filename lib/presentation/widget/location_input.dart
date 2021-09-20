import 'package:flutter/material.dart';

class LocationInputWidget extends StatefulWidget {
  @override
  _LocationInputWidgetState createState() => _LocationInputWidgetState();
}

class _LocationInputWidgetState extends State<LocationInputWidget> {
  String? _locationPreviewUrl;

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
                  onPressed: () {},
                  icon: Icon(Icons.location_on_rounded),
                  label: Text('Current Location'),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
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
