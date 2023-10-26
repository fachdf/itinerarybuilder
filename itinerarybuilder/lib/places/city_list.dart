import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itinerarybuilder/models/place.dart';
import 'package:itinerarybuilder/places/city_detail.dart';
import 'package:http/http.dart' as http;
import 'addplace.dart';

class CityListScreen extends StatefulWidget {

  @override
  State<CityListScreen> createState() => _CityListScreenState();
}

class _CityListScreenState extends State<CityListScreen> {
  late Future<List<Place>> placeList;
  void initState() {
    super.initState();
    placeList = fetchAllPlaces(); // Initialize placeList with data
  }

  void refreshData() {
    placeList = fetchAllPlaces();
  }

  @override
  Widget build(BuildContext context) {
    refreshData();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Places in Tokyo",
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFF5900),
      ),
      body: FutureBuilder<List<Place>>(
        future: placeList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No places found."));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final Place place = snapshot.data![index];
                return Card(
  margin: EdgeInsets.all(8.0),
  child: InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CityDetailsScreen(place: place),
        ),
      );
    },
    child: ListTile(
      title: Row(
        children: [
          Expanded(
            child: Text(
              place.Name ?? 'Place',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(place.Photos?[0]?.Url ?? 'https://i.stack.imgur.com/6KTqy.jpg'),
                fit: BoxFit.cover,
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPlaceScreen()),
          ).then((_) => placeList = fetchAllPlaces());
        },
        tooltip: 'Add Place',
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
        if (value == 'addPlace') {
          // Add your code to show the popup or perform an action
          // when the "+" button is pressed.
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            value: 'addPlace',
            child: Text('Add Place'),
          ),
          // You can add more options as needed
        ];
      },
    );
  }

  Future<List<Place>> fetchAllPlaces() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:7161/api/Place'));

  if (response.statusCode == 200) {
    Iterable<dynamic> jsonData = json.decode(response.body);
    List<Place> places = List<Place>.from(jsonData.map((place) => Place.fromJson(place)));
    return places;
  } else {
    throw Exception('Failed to load places');
  }
}