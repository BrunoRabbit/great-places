import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/routes/routes.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Great Places'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.kPlaceForm);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).loadPlacesDb(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<GreatPlaces>(
                    child: const Center(
                      child: Text('Nenhum local cadastrado!'),
                    ),
                    builder: (context, value, widget) => value.itemsCount == 0
                        ? widget!
                        : ListView.builder(
                            itemCount: value.itemsCount,
                            itemBuilder: (context, i) {
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: FileImage(
                                    value.getItemByIndex(i).image!,
                                  ),
                                ),
                                title: Text(value.getItemByIndex(i).title!),
                                subtitle: Text(
                                  value.getItemByIndex(i).location!.address!,
                                ),
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    Routes.kPlaceDetail,
                                    arguments: value.getItemByIndex(i),
                                  );
                                },
                              );
                            },
                          ),
                  ),
      ),
    );
  }
}
