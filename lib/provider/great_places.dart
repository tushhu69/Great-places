import 'package:flutter/material.dart';
import '../modles/places.dart';
import 'dart:io';
import '../helpers/db_helpers.dart';
import '../helpers/location_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findbyID(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> addPlace(
      String title, File pickedImage, PlaceLocation pickedLocation) async {
    final address = await LocationHelper.getaddress(
        pickedLocation.latitude, pickedLocation.longitude);
    final updatedLocation = PlaceLocation(
        longitude: pickedLocation.longitude,
        adress: address,
        latitude: pickedLocation.latitude);
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: title,
      location: updatedLocation,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelpers.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.adress,
    });
  }

  Future<void> fetchAndsetdata() async {
    final fetch = await DBHelpers.getdata('user_places');
    _items = fetch
        .map((item) => Place(
            id: item['id'],
            image: File(item['image']),
            location: PlaceLocation(
                longitude: item['loc_lat'],
                adress: item['address'],
                latitude: item['loc_lng']),
            title: item['title']))
        .toList();
    notifyListeners();
  }
}
