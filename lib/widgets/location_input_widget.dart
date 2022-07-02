import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'package:great_places/screens/map_screen.dart';
import 'package:great_places/utils/location_util.dart';

class LocationInputWidget extends StatefulWidget {
  final Function onSelectedPosition;

  const LocationInputWidget(this.onSelectedPosition, {Key? key})
      : super(key: key);

  @override
  State<LocationInputWidget> createState() => _LocationInputWidgetState();
}

class _LocationInputWidgetState extends State<LocationInputWidget> {
  String? _previewImageUrl;

  void _showPreview(double lat, double lng) {
    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
      latitude: lat,
      longitude: lng,
    );

    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      final locData = await Location().getLocation();

      _showPreview(locData.latitude!, locData.longitude!);

      widget.onSelectedPosition(LatLng(locData.latitude!, locData.longitude!));
    } catch (e) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => MapScreen(),
      ),
    );

    if (selectedLocation == null) return;

    _showPreview(selectedLocation.latitude!, selectedLocation.longitude!);

    widget.onSelectedPosition(selectedLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImageUrl == null
              ? const Text('Localização não informada')
              : Image.network(
                  _previewImageUrl!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              icon: Icon(
                Icons.location_on,
                color: Theme.of(context).primaryColor,
              ),
              label: Text(
                'Localização Atual',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              onPressed: _getCurrentLocation,
            ),
            TextButton.icon(
              icon: Icon(
                Icons.map,
                color: Theme.of(context).primaryColor,
              ),
              label: Text(
                'Selecione no Mapa',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              onPressed: _selectOnMap,
            ),
          ],
        ),
      ],
    );
  }
}
