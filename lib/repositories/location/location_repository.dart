import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

import 'package:max_dating_app/env/env.dart';
import 'package:max_dating_app/models/models.dart';
import 'package:max_dating_app/repositories/repositories.dart';

class LocationRepository extends BaseLocationRepository {
  // final String key = 'API_KEY';
  final String key = googleMapsAPI;
  // final String key = googleMapsIOS;
  final String types = 'geocode';

  static const baseGoogleMapsUrl = 'https://maps.googleapis.com/maps/api/place';

  @override
  Future<Location> getLocation(String location) async {
    // final String url =
    //     '$baseGoogleMapsUrl/findplacefromtext/json?fields=place_id%2Cname%2Cgeometry&input=$location&inputtype=textquery&key=$key';
    final String url =
        '$baseGoogleMapsUrl/textsearch/json?query=$location&key=$key';

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    // var results = json['candidates'][0] as Map<String, dynamic>;
    var results = json['results'][0] as Map<String, dynamic>;

    return Location.fromJson(results);
  }
}
