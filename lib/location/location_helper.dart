const GOOGLE_API_KEY = 'API_KEY';

class LocationHelper {
  static Uri generateLocationPreview({
    required double latitude,
    required double longitude,
  }) =>
      Uri.https(
        'maps.googleapis.com',
        'maps/api/staticmap',
        {
          'center': '$latitude,$longitude',
          'zoom': '17',
          'size': '600x300',
          'maptype': 'roadmap',
          'markers': 'color:blue|$latitude,$longitude',
          'key': GOOGLE_API_KEY,
        },
      );
}
