import 'package:flutter/material.dart';
import 'package:location/location.dart';
//import 'package:path/path.dart';
import '../helpers/location_helper.dart';
import '../screens/map_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectLocation;
  LocationInput(this.onSelectLocation);
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewUrl;
  void _showpewview(double lat, double lng) {
    final staticimageurl = LocationHelper.generateLocationPreviewImage(
      latitude: lat,
      longitude: lng,
    );
    setState(() {
      _previewUrl = staticimageurl;
    });
  }

  Future<void> getcurrentlocation() async {
    try {
      final locdata = await Location().getLocation();
      _showpewview(locdata.latitude, locdata.longitude);
      widget.onSelectLocation(locdata.latitude, locdata.longitude);
    } catch (error) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _selectonMap() async {
      final selectLocation = //-------------V herer LATlNG WILL TELL THAT the page that is popped will give a LatLng
          await Navigator.of(context).push<LatLng>(MaterialPageRoute(
              fullscreenDialog: true,
              builder: (ctx) => MapScreen(
                    isSelect: true,
                  )));
      if (selectLocation == null) {
        return;
      }
      _showpewview(selectLocation.latitude, selectLocation.longitude);
      widget.onSelectLocation(
          selectLocation.latitude, selectLocation.longitude);
    }

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.black,
            ),
          ),
          child: _previewUrl == null
              ? Center(
                  child: Text(
                    'No Location',
                    textAlign: TextAlign.center,
                  ),
                )
              : Image.network(
                  _previewUrl,
                  fit: BoxFit.cover,
                ),
          height: 180,
          width: double.infinity,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: getcurrentlocation,
              icon: Icon(
                Icons.location_on,
                color: Theme.of(context).primaryColor,
              ),
              label: Text(
                'Current Location',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
            TextButton.icon(
              onPressed: _selectonMap,
              icon: Icon(Icons.map),
              label: Text(
                ('Select on Map'),
              ),
            )
          ],
        )
      ],
    );
  }
}
