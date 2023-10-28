import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itinerarybuilder/itinerary/itinerary_detail.dart';
import 'package:itinerarybuilder/models/itinerary.dart';
import 'package:itinerarybuilder/models/itinerary.dart';
//import 'package:itinerarybuilder/itinerary/itinerary_detail.dart';
import 'package:http/http.dart' as http;
import 'package:itinerarybuilder/service/firestore.dart';
import 'add_itinerary.dart';

class ItineraryListScreen extends StatefulWidget {

  @override
  State<ItineraryListScreen> createState() => _ItineraryListScreenState();
}

class _ItineraryListScreenState extends State<ItineraryListScreen> {
  late Future<List<Itinerary>> itineraryList;
  void initState() {
    super.initState();
    itineraryList = fetchAllItinerary(); // Initialize itineraryList with data
  }

  void refreshData() {
    itineraryList = fetchAllItinerary();
  }

  @override
  Widget build(BuildContext context) {
    refreshData();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Itinerary",
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFF5900),
      ),
      body: FutureBuilder<List<Itinerary>>(
        future: FirestoreService().getAllItinerary(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot);
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No itinerarys found."));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final Itinerary itinerary = snapshot.data![index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItineraryDetailsScreen(ItineraryId: itinerary.Id),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              itinerary.Name ?? 'itinerary',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          // Navigator.push(
          //   context,

          //   //MaterialPageRoute(builder: (context) => AddItineraryScreen()),
          // ).then((_) => itineraryList = fetchAllItinerary());
          // itineraryList = fetchAllItinerary();
          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>AddItineraryScreen()),).whenComplete(()=>refreshData()).then((value) => setState((){}));
        },
        tooltip: 'Add itinerary',
        child: const Icon(Icons.add),
      ),
    );
  }
}


PopupMenuButton<String> buildPopupMenuButton(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(
        Icons.add,
        color: Colors.white,
      ),
      onSelected: (value) {
        if (value == 'additinerary') {
          // Add your code to show the popup or perform an action
          // when the "+" button is pressed.
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            value: 'additinerary',
            child: Text('Add itinerary'),
          ),
          // You can add more options as needed
        ];
      },
    );
  }

  Future<List<Itinerary>> fetchAllItinerary() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:7161/api/Itinerary'));

  if (response.statusCode == 200) {
    Iterable<dynamic> jsonData = json.decode(response.body);
    List<Itinerary> itineraries = List<Itinerary>.from(jsonData.map((itinerary) => Itinerary.fromJson(itinerary)));
    return itineraries;
  } else {
    throw Exception('Failed to load itineraries');
  }
}

Future<Itinerary> getItineraryById(int itineraryId) async {
  final url = Uri.parse('http://10.0.2.2:7161/api/itinerary/$itineraryId'); // Replace with your actual API URL

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonData = json.decode(response.body);
    final Itinerary updatedItinerary = Itinerary.fromJson(jsonData); // Assuming you have a constructor like `Itinerary.fromJson` to create an Itinerary object from JSON data.
    return updatedItinerary;
  } else {
    throw Exception('Failed to get itinerary by ID');
  }
}