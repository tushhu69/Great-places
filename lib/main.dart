import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './provider/great_places.dart';
import './screens/places_list_screen.dart';
import './screens/add_placees_screens.dart';
import './screens/places_details_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GreatPlaces',
        theme:
            ThemeData(primaryColor: Colors.blue, accentColor: Colors.blueGrey),
        home: PlacesList(),
        routes: {
          AddPlaces.routeName: (ctx) => AddPlaces(),
          PlaceDetailsScreen.routeName: (ctx) => PlaceDetailsScreen(),
        },
      ),
    );
  }
}
