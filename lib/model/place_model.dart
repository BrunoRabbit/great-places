import 'dart:io';

import 'package:great_places/model/place_location_model.dart';

class PlaceModel {
  final String? id;
  final String? title;
  final PlaceLocation? location;
  final File? image;

  PlaceModel({
    this.id,
    this.title,
    this.location,
    this.image,
  });
}
