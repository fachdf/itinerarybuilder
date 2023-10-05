import 'package:flutter/material.dart';
import 'package:itinerarybuilder/places/place.dart';
import 'package:itinerarybuilder/places/place_detail.dart';

import 'package:flutter/material.dart';


class SavedPlaceScreen extends StatefulWidget {
  @override
  _SavedPlaceScreenState createState() => _SavedPlaceScreenState();
}

class _SavedPlaceScreenState extends State<SavedPlaceScreen> {
  List<Place> savedPlaces = [];

  @override
  void initState() {
    super.initState();
    // Calculate the saved places within the screen
    savedPlaces = getSavedPlaces(cityList);
  }

  List<Place> getSavedPlaces(List<City> cityList) {
    List<Place> savedPlaces = [];

    for (City city in cityList) {
      for (Place place in city.places) {
        if (place.isFavorite) {
          savedPlaces.add(place);
        }
      }
    }

    return savedPlaces;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Saved Places", 
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.bold, 
            )
        ),
        backgroundColor: const Color(0xFFFF5900),
      ),
      body: savedPlaces.isEmpty
        ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "No Favorite Place",
                    style: TextStyle(
                      fontSize: 18.0,
                      
                    ),
                  ),
                  // You can add a button or other UI elements for user interaction here
                ],
              ),
            )  
      : ListView.builder(
        itemCount: savedPlaces.length,
        itemBuilder: (BuildContext context, int index) {
          final Place place = savedPlaces[index];
          return ListTile(
            leading: Container(
              width: 60.0, // Width of the thumbnail
              height: 60.0, // Height of the thumbnail
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(place.imgUrls[0]), // Display the thumbnail image
                  fit: BoxFit.cover, // Crop the image to fit the container
                ),
              ),
            ),
            title: Text(place.name),
            subtitle: Text('Price: \$${place.price}'),
            onTap: () {
              // Handle place tap, e.g., navigate to the place details screen
              // You can pass the selected place to the details screen.
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlaceDetailsScreen(place: place),
                ),
              );
            },
          );
        },
      ),
    );
  }
}