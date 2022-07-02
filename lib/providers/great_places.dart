import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/model/place_location_model.dart';
import 'package:great_places/model/place_model.dart';
import 'package:great_places/utils/db_util.dart';
import 'package:great_places/utils/location_util.dart';

class GreatPlaces extends ChangeNotifier {
  List<PlaceModel> _items = [];

  Future<void> loadPlacesDb() async {
    final dataList = await DbUtil.getData('places');
    _items = dataList
        .map(
          (item) => PlaceModel(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: PlaceLocation(
                latitude: item['latitude'],
                longitude: item['longitude'],
                address: item['address']),
          ),
        )
        .toList();
    notifyListeners();
  }

  // nao devolver a referencia da lista para nao ser modificada globalmente
  // e os Listeners nao serao notificados
  List<PlaceModel> get items {
    return [..._items];
  }

  // para nao criar outra variavel para pegar a quantidade
  int get itemsCount {
    return _items.length;
  }

  PlaceModel getItemByIndex(int index) {
    return _items[index];
  }

  Future<void> addPlace(
    String title,
    File image,
    LatLng position,
  ) async {
    String address = await LocationUtil.getAddressFrom(position);
    final newPlace = PlaceModel(
      id: Random().nextDouble().toString(),
      title: title,
      image: image,
      location: PlaceLocation(
        latitude: position.latitude,
        longitude: position.longitude,
        address: address,
      ),
    );
    _items.add(newPlace);
    DbUtil.insert('places', {
      'id': newPlace.id!,
      'title': newPlace.title!,
      'image': newPlace.image!.path,
      'latitude': position.latitude,
      'longitude': position.longitude,
      'address': address,
    });
    notifyListeners();
  }
}
