import 'dart:convert';

import 'package:http/http.dart' as http;

const googleAPIKey = 'AIzaSyDUaoEhrOF4kQaygxwDDi6Z6e5NDYpimfA';

class LocationHelper {
  static String generateLocationPreviewImage({
    required double latitude,
    required double longitude,
  }) {
    final url = Uri.https(
      'maps.googleapis.com',
      '/maps/api/staticmap',
      {
        'center': '$latitude,$longitude',
        'zoom': '16',
        'size': '400x400',
        'markers': 'color:red|$latitude,$longitude',
        'key': googleAPIKey,
      },
    );

    return url.toString();
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url = Uri.https(
      'maps.googleapis.com',
      '/maps/api/geocode/json',
      {
        'latlng': '$lat,$lng',
        'key': googleAPIKey,
      },
    );
    final response = await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
