import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itinerarybuilder/models/itinerary.dart';
import 'package:itinerarybuilder/models/itinerary_place.dart';
import 'package:itinerarybuilder/models/place.dart';
import 'package:itinerarybuilder/service/firestore.dart';


class AddPlaceToItineraryScreen extends StatefulWidget {
  final Itinerary itinerary;

  AddPlaceToItineraryScreen({required this.itinerary});

  @override
  _AddPlaceToItineraryScreenState createState() => _AddPlaceToItineraryScreenState();
}

class _AddPlaceToItineraryScreenState extends State<AddPlaceToItineraryScreen> {
  TextEditingController visitTimeController = TextEditingController();
  // Other properties and controllers...
  Place? selectedPlace;
  // Create a list to hold all places from your database

List<Place> allPlaces = [];
List<Place> addedPlaces = [];
List<Place> availablePlaces = [];

@override
void initState() {
  super.initState();
  
  // Fetch all places and added places
  Future.wait([
    fetchAllPlacesFromDatabase(),
    fetchAddedPlacesFromDatabase(widget.itinerary.Id),
  ]).then((results) {
    setState(() {
      allPlaces = results[0];
      addedPlaces = results[1];
      if(addedPlaces.length == 0){
        availablePlaces = allPlaces;
      }
      else{
        print("all place: ${allPlaces[0].Id}");
        print("all place: ${allPlaces[1].Id}");
        print("addedPlaces: ${addedPlaces[0].Id}");
        // Filter available places
        availablePlaces = allPlaces.where((place) {
          // Check if the place is not in the addedPlaces list
          return !addedPlaces.any((addedPlace) => addedPlace.Id == place.Id);
        }).toList();
        print("availablePlaces: ${availablePlaces.toString()}");
      }
    });
  }).catchError((error) {
    // Handle errors, e.g., show an error message
    print('Failed to fetch places: $error');
  });
}

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Place", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFFFF5900),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Other text fields...

              // Dropdown to select places not in fetchPlacesForItinerary
              DropdownButton<Place>(
                hint: Text("Select a Place"),
                value: selectedPlace, // Track the selected place
                items: availablePlaces.map((Place place) {
                  return DropdownMenuItem<Place>(
                    value: place,
                    child: Text(place.Name,
                                style: TextStyle(
                                  color: Colors.black, // Change the text color to blue
                                ),
                            ), // Display the place's name or any other property you want to show
                  );
                }).toList(),
                onChanged: (Place? newValue) {
                  setState(() {
                    selectedPlace = newValue!; // Update the selected place
                  });
                },
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: visitTimeController,
                decoration: InputDecoration(labelText: "Visit Time"),
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        primary: Colors.orange,
                        onPrimary: Colors.white,
                      ),
                      onPressed: () {
                        if (selectedPlace != null) {
                          // Save the place data here
                          final number = 1;
                          final visitTime = int.parse(visitTimeController.text);

                          FirestoreService().addItineraryPlace(
                            number,
                            visitTime,
                            0,
                            selectedPlace!.Id,
                            widget.itinerary.Id
                          );
                          // Then, navigate back to the previous screen
                          Navigator.pop(context);
                        }
                      },
                      child: Text("Submit"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<List<Place>> fetchAllPlacesFromDatabase() async {
    // Fetch all places from the database using your FirestoreService or other method
    try {
      List<Place> places = await FirestoreService().getPlace(); // Replace with your method to fetch all places
      return places;
    } catch (e) {
      // Handle errors, e.g., show an error message
      print('Failed to fetch places: $e');
      return [];
    }
}

Future<List<Place>> fetchAddedPlacesFromDatabase(String Id) async {
    // Fetch all places from the database using your FirestoreService or other method
    try {
      List<Place> places = await FirestoreService().getPlacesForItinerary(Id); // Replace with your method to fetch all places
      return places;
    } catch (e) {
      // Handle errors, e.g., show an error message
      print('Failed to fetch places: $e');
      return [];
    }
}



// Future<void> addPlaceToItinerary(int ItineraryId, int PlaceId, int Number, int VisitTime) async {
//   final url = Uri.parse('http://10.0.2.2:7161/api/Itinerary/AddPlaceToItinerary'); // Replace with your API endpoint

//   final Map<String, dynamic> data = {
//     "itineraryId": ItineraryId,
//     "placeId": PlaceId,
//     "number": Number,
//     "visitTime": VisitTime,
//     "isVisited": 0
//   };

//   final response = await http.put(
//     url,
//     headers: {
//       'Content-Type': 'application/json',
//     },
//     body: jsonEncode(data),
//   );

//   if (response.statusCode == 201) {
//     // The place was successfully created
//     // You can handle the success as needed
//   } else {
//     // Handle errors or show an error message
//     throw Exception('Failed to add place: ${response.statusCode}');
//   }
// }

// // Future<List<Place>> fetchPlacesForItinerary(Itinerary itinerary) async {
// //   final List<Place> places = [];
// //   for (ItineraryPlace itineraryPlace in itinerary.ItineraryPlaces) {
// //     final Place place = await fetchPlaceById(itineraryPlace.placeId);
// //     places.add(place);
// //   }
// //   return places;
// // }


// // Future<Place> fetchPlaceById(int id) async {
// //   final response = await http.get(Uri.parse('http://10.0.2.2:7161/api/Place/$id'));

// //   if (response.statusCode == 200) {
// //     final Map<String, dynamic> jsonData = json.decode(response.body);
// //     return Place.fromJson(jsonData); // Assuming you have a constructor like `Place.fromJson` to create a Place object from JSON data.
// //   } else {
// //     throw Exception('Failed to load place');
// //   }
// // }

// //   Future<List<Place>> fetchAllPlaces() async {
// //   final response = await http.get(Uri.parse('http://10.0.2.2:7161/api/Place'));

// //   if (response.statusCode == 200) {
// //     Iterable<dynamic> jsonData = json.decode(response.body);
// //     List<Place> places = List<Place>.from(jsonData.map((place) => Place.fromJson(place)));
// //     return places;
// //   } else {
// //     throw Exception('Failed to load places');
// //   }
// // }