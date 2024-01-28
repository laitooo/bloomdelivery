import 'package:bloomdeliveyapp/business_logic/models/place/place_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GoogleMapsServices {
  final apiKey = "AIzaSyDRGCPRqRVyU9w2lYkscjAA_TInIxoE9jg";

  Future<String> getRouteCoordinatesBetweenTwoPoints(
      LatLng l1, LatLng l2) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=$apiKey";
    http.Response response = await http.get(Uri.parse(url));
    Map values = jsonDecode(response.body);
    return values["routes"][0]["overview_polyline"]["points"];
  }

  Future<String> getRouteCoordinatesForMultiplePoints(
      List<LatLng> points) async {
    if (points.length < 3) {
      return getRouteCoordinatesBetweenTwoPoints(points[0], points[1]);
    }

    String origin = '${points[0].latitude},${points[0].longitude}';
    String waypoints = points
        .sublist(1, points.length - 1)
        .map((point) => '${point.latitude},${point.longitude}')
        .join('|');
    String destination = '${points.last.latitude},${points.last.longitude}';

    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${origin}&waypoints=${waypoints}&destination=${destination}&key=$apiKey";
    http.Response response = await http.get(Uri.parse(url));
    Map values = jsonDecode(response.body);
    return values["routes"][0]["overview_polyline"]["points"];
  }

  Future<String> getPlaceName(LatLng position) async {
    String apiUrl = 'https://maps.googleapis.com/maps/api/geocode/json?';
    String latLng = '${position.latitude},${position.longitude}';
    String url = '$apiUrl&latlng=$latLng&key=$apiKey';

    print('started loading place name for position $position');
    var response = await http.get(Uri.parse(url));
    print('loaded place $response');
    return (jsonDecode(response.body))['results'][0]['formatted_address'];
  }

  Future<List<Place>> searchPlace(String query) async {
    String apiUrl =
        'https://maps.googleapis.com/maps/api/place/textsearch/json?query=';

    String url = '$apiUrl${query.replaceAll(' ', '%20')}&key=$apiKey';

    var response = await http.get(Uri.parse(url));
    print('search url ${url}');
    print('search response ${response.body}');

    List<dynamic> results = (jsonDecode(response.body))['results'];

    return results.map((r) {
      return Place(
        name: r['name'],
        longitude: r['geometry']['location']['lng'],
        latitude: r['geometry']['location']['lat'],
      );
    }).toList();
  }
}
