import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:itinerarybuilder/home/home.dart';
import 'package:itinerarybuilder/places/place.dart';
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
  
  final List<Widget> _screens = [
      const MyHomePage(),
      CityListScreen(cityList: cityList),
      SavedPlaceScreen()
    ];

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

List<Place> getSavedPlaces(List<City> cityList) {
  print("hello?");
  List<Place> savedPlaces = [];
  for (City city in cityList) {
    for (Place place in city.places) {
      print(place.isFavorite);
      if (place.isFavorite) {
        savedPlaces.add(place);
      }
    }
  }

  return savedPlaces;
}