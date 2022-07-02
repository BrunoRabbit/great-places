import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/routes/routes.dart';
import 'package:great_places/screens/home_screen.dart';
import 'package:provider/provider.dart';

void application() async {
  await dotenv.load(fileName: ".env");
  runApp(
    const Application(),
  );
}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GreatPlaces(),
      child: MaterialApp(
        title: '',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          colorScheme: ColorScheme.fromSwatch(accentColor: Colors.amber),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: Routes.appRoutes,
        home: const HomeScreen(),
      ),
    );
  }
}
