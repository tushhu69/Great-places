import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import '../screens/image_inout.dart';
import '../provider/great_places.dart';
import '../widgets/place_input.dart';
//import '../helpers/location_helper.dart';
import '../modles/places.dart';

class AddPlaces extends StatefulWidget {
  static const routeName = '/-addpalces';

  @override
  _AddPlacesState createState() => _AddPlacesState();
}

class _AddPlacesState extends State<AddPlaces> {
  PlaceLocation _pickedLocation;
  var formkey = GlobalKey<FormState>();
  var title;
  File _pickedImage;
  @override
  Widget build(BuildContext context) {
    void saveform() {
      final valid = formkey.currentState.validate();
      if (!valid) {
        return;
      }
      if (_pickedLocation == null) return;

      formkey.currentState.save();
      Provider.of<GreatPlaces>(context, listen: false)
          .addPlace(title, _pickedImage, _pickedLocation);
      Navigator.of(context).pop();
    }

    void _selectedImage(File clickedimage) {
      _pickedImage = clickedimage;
    }

    void _selectplace(double lat, double lng) {
      _pickedLocation =
          PlaceLocation(longitude: lng, adress: null, latitude: lat);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new place'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(9),
                child: Column(
                  children: [
                    Form(
                      key: formkey,
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Title'),
                        textInputAction: TextInputAction.done,
                        onSaved: (val) {
                          title = val;
                        },
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Please enter a TITLE';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(_selectedImage),
                    SizedBox(
                      height: 10,
                    ),
                    LocationInput(_selectplace),
                  ],
                ),
              ),
            ),
          ),
          // ignore: deprecated_member_use
          RaisedButton.icon(
            icon: Icon(
              Icons.add,
              color: Theme.of(context).accentColor,
            ),
            label: Text('Add Places'),
            onPressed: saveform,
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize
                .shrinkWrap, //to remove the spacve between the button and the bottonm of the screen
          ),
        ],
      ),
    );
  }
}
