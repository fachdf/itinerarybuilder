import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

import 'package:itinerarybuilder/home/home.dart';
import 'package:itinerarybuilder/models/place.dart';
import 'package:itinerarybuilder/places/city_list.dart';
import 'package:itinerarybuilder/saved_places/saved_places.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  int _currentIndex = 0;
  late Future<List<Place>> placeList;
  final List<Widget> _screens = [
      const MyHomePage(),
      CityListScreen(),
      //SavedPlaceScreen()
    ];

  void initState() {
    super.initState();
    placeList = fetchAllPlaces(); // Initialize placeList with data
  }

  // Create a method to refresh the data
  Future<void> refreshData() async {
    setState(() {
      placeList = fetchAllPlaces();
    });
  }

  @override
  Widget build(BuildContext context) {
    
    
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          fontFamily: GoogleFonts.nunito().fontFamily,
          brightness: Brightness.light,
          textTheme: const TextTheme(
            bodyLarge: TextStyle(fontSize: 18),
            bodyMedium: TextStyle(fontSize: 16),
            labelLarge: TextStyle(
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
            ),
            displayLarge: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            titleMedium: TextStyle(
              color: Colors.grey,
            ),
          ),
          buttonTheme: const ButtonThemeData(),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 89, 0)),
        useMaterial3: true,
      ),
      home: Scaffold(
              body: _screens[_currentIndex], // Display the selected screen
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: (currentIndex) {
                  // Update the current index when a tab is tapped
                  setState(() {
                    _currentIndex = currentIndex;
                  });
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(
                      FontAwesomeIcons.house,
                      size: 20,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      FontAwesomeIcons.locationPin,
                      size: 20,
                    ),
                    label: 'Places',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      FontAwesomeIcons.solidHeart,
                      size: 20,
                    ),
                    label: 'About',
                  ),
                ],
                selectedItemColor: const Color(0xFFFF5900), // Customize the selected item color
                unselectedItemColor: Colors.grey, // Customize the unselected item color
                selectedIconTheme: const IconThemeData(color: const Color(0xFFFF5900)),
                unselectedIconTheme:  const IconThemeData(color: Colors.grey),
              ),
            ),
    );
  }
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