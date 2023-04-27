// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final String placeId;
  final String name;
  final num lat;
  final num lon;

  const Location({
    this.placeId = '',
    this.name = '',
    required this.lat,
    required this.lon,
  });

  static const initialLocation = Location(
    lat: 0,
    lon: 0,
  );

  Location copyWith({
    String? placeId,
    String? name,
    num? lat,
    num? lon,
  }) {
    // print('location model copyWith');
    return Location(
      placeId: placeId ?? this.placeId,
      name: name ?? this.name,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
    );
  }

  factory Location.fromJson(Map<String, dynamic> json) {
    // print('location model fromJson');
    // print(json);
    print('dank');
    print(json.keys);
    if (json.keys.contains('place_id')) {
      print('place_id');
      print(json['place_id']);
      print(json['name']);
      print(json['geometry']);
      print(json['geometry']['location']);
      print(json['geometry']['location']['lat']);
      print(json['geometry']['location']['lng']);
      return Location(
        placeId: json['place_id'],
        name: json['name'],
        lat: json['geometry']['location']['lat'],
        lon: json['geometry']['location']['lng'],
      );
    } else {
      return Location(
        placeId: json['placeId'],
        name: json['name'],
        lat: json['lat'],
        lon: json['lon'],
      );
    }
  }

  factory Location.fromSnapshot(Map<String, dynamic> json) {
    // print('location model fromJson');
    // print(json);
    double tempLat = json['lat'] + .0;
    double tempLon = json['lon'] + .0;

    return Location(
      placeId: json['place_id'] ?? '',
      name: json['name'] ?? '',
      lat: tempLat,
      lon: tempLon,
    );
  }

  Map<String, dynamic> toMap() {
    // print('location model toMap');
    return {
      'placeId': placeId,
      'name': name,
      'lat': lat,
      'lon': lon,
    };
  }

  @override
  List<Object?> get props => [
        placeId,
        name,
        lat,
        lon,
      ];
}
