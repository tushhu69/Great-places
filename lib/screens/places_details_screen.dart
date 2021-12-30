import 'package:flutter/material.dart';
import 'package:gerat_palaces/provider/great_places.dart';
import 'package:provider/provider.dart';
import '../screens/map_screen.dart';

class PlaceDetailsScreen extends StatelessWidget {
  static final routeName = '/placedetails';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final idplace =
        Provider.of<GreatPlaces>(context, listen: false).findbyID(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(idplace.title),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              idplace.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            idplace.location.adress,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(
            height: 10,
          ),
          // ignore: deprecated_member_use
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (ctx) => MapScreen(
                        initialLocation: idplace.location,
                      )));
            },
            textColor: Theme.of(context).primaryColor,
            child: Text('View On Map'),
          ),
        ],
      ),
    );
  }
}
