import 'package:flutter/material.dart';
import 'package:great_places/model/place_model.dart';
import 'package:great_places/screens/map_screen.dart';

class PlaceDetailsScreen extends StatelessWidget {
  const PlaceDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlaceModel placeModel =
        ModalRoute.of(context)!.settings.arguments as PlaceModel;

    return Scaffold(
      appBar: AppBar(
        title: Text(placeModel.title!),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Image.file(
              placeModel.image!,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            placeModel.location!.address!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton.icon(
            icon: const Icon(Icons.map),
            label: const Text('Ver no mapa'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MapScreen(
                    isReadOnly: true,
                    initialLocation: placeModel.location!,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
