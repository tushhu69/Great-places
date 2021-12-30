import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../modles/places.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;

  final bool isSelect;
  MapScreen(
      {this.isSelect = false,
      this.initialLocation = const PlaceLocation(
          adress: null, latitude: 37.422, longitude: -122.34)});

  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickeLocation;
  void _selectLOcation(LatLng position) {
    //here google automatically provides us with the on taped location coordinates
    setState(() {
      _pickeLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Map'),
          actions: [
            if (widget.isSelect)
              IconButton(
                icon: Icon(Icons.check),
                onPressed: _pickeLocation == null
                    ? null
                    : () {
                        Navigator.of(context).pop(_pickeLocation);
                      },
              ),
          ],
        ),
        body: GoogleMap(
          //will take the height of the parent widget
          initialCameraPosition: CameraPosition(
              target: LatLng(widget.initialLocation.latitude,
                  widget.initialLocation.longitude),
              zoom: 13),
          onTap: widget.isSelect ? _selectLOcation : null,
          markers: (_pickeLocation == null && widget.isSelect)
              ? {}
              : {
                  Marker(
                    markerId: MarkerId('m1'),
                    position: _pickeLocation ??
                        LatLng(widget.initialLocation.latitude,
                            widget.initialLocation.longitude),
                  )
                },
        ));
  }
}
