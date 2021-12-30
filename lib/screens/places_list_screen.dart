import 'package:flutter/material.dart';
import '../screens/add_placees_screens.dart';
import 'package:provider/provider.dart';
import '../screens/places_details_screen.dart';
import '../provider/great_places.dart';

class PlacesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Places'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AddPlaces.routeName);
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false)
              .fetchAndsetdata(),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                )
              : Consumer<GreatPlaces>(
                  builder: (ctx, greatPlaces, ch) =>
                      greatPlaces.items.length <= 0
                          ? ch
                          : ListView.builder(
                              itemBuilder: (ctx, i) => ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      FileImage(greatPlaces.items[i].image),
                                ),
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      PlaceDetailsScreen.routeName,
                                      arguments: greatPlaces.items[i].id);
                                },
                                title: Text(greatPlaces.items[i].title),
                                subtitle:
                                    Text(greatPlaces.items[i].location.adress),
                              ),
                              itemCount: greatPlaces.items.length,
                            ),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.grey,
                    ),
                  ),
                ),
        ));
  }
}
