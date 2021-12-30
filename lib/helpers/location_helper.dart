import 'package:http/http.dart' as http;
import 'dart:convert';

const GOOGLE_API_KEY = 'AIzaSyD_INg92pwynYc5YhBqT9RDQTtv4l313vQ';

class LocationHelper {
  static String generateLocationPreviewImage(
      {double latitude, double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=AIzaSyD_INg92pwynYc5YhBqT9RDQTtv4l313vQ';
  }

  static Future<String> getaddress(double lat, double lng) async {
    final url = //here we use the reverse geocoding api which copnverts coordinates inot human readable form
        Uri.parse(
            'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyD_INg92pwynYc5YhBqT9RDQTtv4l313vQ');
    final response = await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
