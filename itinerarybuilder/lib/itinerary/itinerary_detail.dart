import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:itinerarybuilder/itinerary/add_place_to_itinerary.dart';
import 'package:itinerarybuilder/models/itinerary.dart';

import 'package:itinerarybuilder/models/itinerary_place.dart';
import 'package:itinerarybuilder/models/place.dart';
import 'package:itinerarybuilder/places/place_detail.dart';

import 'package:http/http.dart' as http;
import 'package:itinerarybuilder/service/firestore.dart';


class ItineraryDetailsScreen extends StatefulWidget {
  final String ItineraryId;

  ItineraryDetailsScreen({required this.ItineraryId});

  @override
  _ItineraryDetailsScreenState createState() => _ItineraryDetailsScreenState();
}

class _ItineraryDetailsScreenState extends State<ItineraryDetailsScreen> {
  //List<Place> addedPlace = [];
  void initState() {
    super.initState();
    // fetchItineraryPlacesFromDatabase(widget.ItineraryId).then((places) {
    //     setState(() {
    //       addedPlace = places;
    //     });
    //   });
  }
  
  @override
  late Itinerary data;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Itinerary Detail",
          style: TextStyle(
            color: Colors.white, // Set text color to white
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFF5900)
      ),     
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: FirestoreService().getItineraryById(widget.ItineraryId),
          builder:(context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot}"));
            } else if (!snapshot.hasData ) {
              return Center(child: Text("No Itinerary found."));
            }
            data = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                  data!.Name ?? "Unknown",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                ),
          
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('List of Places'),
                ),
          
                FutureBuilder<List<Place>>(
                  future: FirestoreService().getPlacesForItinerary(widget.ItineraryId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(); // Display a loading indicator while fetching data.
                    } else if (snapshot.hasError) {
                      print(snapshot);
                      return Text("Error: ${snapshot.error}");
                    } else if (!snapshot.hasData) {
                      return Text("No data available.");
                    } else {
                      //print(snapshot.data.toString());
                      List<Place>? places = snapshot.data;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: places?.length,
                        itemBuilder: (BuildContext context, int index) {
                          final Place place = places![index];
          
                          return Dismissible(
                            key: UniqueKey(),
                            onDismissed: (direction) async {
                              // Remove the item from the data source.
                                await FirestoreService().deleteItineraryPlace(widget.ItineraryId, place.Id);
                                places!.removeAt(index);
                            },
                            child: ListTile(
                              leading: Container(
                                width: 60.0,
                                height: 60.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(place.PhotoUrls?[0] ?? 'https://i.stack.imgur.com/6KTqy.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: Text(place.Name),
                              //subtitle: Text('Price: \$${place.price}'),
                            //   trailing: IconButton(
                            //     icon: Icon(
                            //       place. ? Icons.favorite : Icons.favorite_border,
                            //       color: place.isFavorite ? Colors.red : Colors.grey,
                            //     ),
                            //   // Add other UI elements here to display information about the place
                            // );
                            onTap: () {
                                              // Handle place tap, e.g., navigate to the place details screen
                                              // You can pass the selected place to the details screen.
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlaceDetailsScreen(placeId: place.Id),
                              ),
                            );
                                              },
                                            
                            ),
                          );
                        },
                      );
                    }
                  },
                )  
              ],
            );
          },
          
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async  {
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddPlaceToItineraryScreen(itinerary: data,)),
        ).then((value) => setState((){}));
                },
        tooltip: 'Add Place to Itinerary',
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Future<List<Place>> fetchItineraryPlacesFromDatabase(String Id) async {
//     // Fetch all places from the database using your FirestoreService or other method
//     try {
//       List<Place> places = await FirestoreService().getPlacesForItinerary(Id); // Replace with your method to fetch all places
//       return places;
//     } catch (e) {
//       // Handle errors, e.g., show an error message
//       print('Failed to fetch places: $e');
//       return [];
//     }
//   }


  Future<List<Itinerary>> fetchAllItinerary() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:7161/api/Itinerary/'));

  if (response.statusCode == 200) {
    Iterable<dynamic> jsonData = json.decode(response.body);
    List<Itinerary> itineraries = List<Itinerary>.from(jsonData.map((itinerary) => Itinerary.fromJson(itinerary)));
    return itineraries;
  } else {
    throw Exception('Failed to load itineraries');
  }
}


// Future<List<Place>> fetchPlacesForItinerary(Itinerary itinerary) async {
//   final List<Place> places = [];
//   for (ItineraryPlace itineraryPlace in itinerary.ItineraryPlaces) {
//     final Place place = await fetchPlaceById(itineraryPlace.placeId);
//     places.add(place);
//   }
//   return places;
// }


// Future<Place> fetchPlaceById(int id) async {
//   final response = await http.get(Uri.parse('http://10.0.2.2:7161/api/Place/$id'));

//   if (response.statusCode == 200) {
//     final Map<String, dynamic> jsonData = json.decode(response.body);
//     return Place.fromJson(jsonData); // Assuming you have a constructor like `Place.fromJson` to create a Place object from JSON data.
//   } else {
//     throw Exception('Failed to load place');
//   }
// }

Future<void> deletePlaceFromItinerary(int ItineraryId, int PlaceId) async {
  final url = Uri.parse(('http://10.0.2.2:7161/api/Itinerary/DeletePlaceFromItinerary'));

  final Map<String, dynamic> data = {
    "itineraryId": ItineraryId,
    "placeId": PlaceId,
  };

  final response = await http.put(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(data),
  );

  if (response.statusCode == 201 || response.statusCode == 200) {
    // The place was successfully created
    // You can handle the success as needed
  } else {
    // Handle errors or show an error message
    throw Exception('Failed to delete place: ${response.statusCode}');
  }
}