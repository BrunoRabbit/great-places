import 'package:flutter/material.dart';
import 'package:great_places/screens/place_details_screen.dart';
import 'package:great_places/screens/place_form_screen.dart';

class Routes {
  static const String kPlaceForm = '/place-form';
  static const String kPlaceDetail = '/place-detail';

  static Map<String, WidgetBuilder> appRoutes = {
    kPlaceForm: (context) => const PlaceFormScreen(),
    kPlaceDetail: (context) => const PlaceDetailsScreen(),
  };
}
